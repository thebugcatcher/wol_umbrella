defmodule WolWeb.PersonController do
  use WolWeb, :controller

  import Ecto.Query

  alias Wol.{Organization, Repo}
  alias Organization.{Person, Relationship}

  def index(conn, _params) do
    people = Organization.list_people()
    render(conn, "index.html", people: people)
  end

  def new(conn, _params) do
    changeset = Organization.change_person(%Person{})
    people = Organization.list_people()
    render(conn, "new.html", changeset: changeset, people: people)
  end

  def create(conn, %{"person" => person_params}) do
    mentor_name = Map.get(person_params, "mentor")
    supervisor_name = Map.get(person_params, "supervisor")

    case Organization.create_person(person_params) do
      {:ok, person} ->
        create_relationship(person, mentor_name, "mentor")
        create_relationship(person, supervisor_name, "supervisor")

        conn
        |> put_flash(:info, "Person created successfully.")
        |> redirect(to: person_path(conn, :show, person))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp create_relationship(_person, "", _relation), do: {:ok, :done}

  defp create_relationship(person, relative_name, relation) do
    relative = Wol.Repo.get_by!(Organization.Person, [name: relative_name])

    Relationship.changeset(%Relationship{}, %{
      person2_id: person.id,
      person1_id: relative.id,
      relationship_type: relation})
    |> Wol.Repo.insert!()
  end

  def show(conn, %{"id" => id}) do
    person = Organization.get_person!(id)
    mentor = get_relative(person, "mentor")
    supervisor = get_relative(person, "supervisor")

    render(conn, "show.html", person: person, mentor: mentor, supervisor: supervisor)
  end

  defp get_relative(person, relation) do
    Relationship
    |> join(:inner, [r], p in Person, r.person1_id == p.id)
    |> where([r], r.person2_id == ^person.id)
    |> where([r], r.relationship_type == ^relation)
    |> last(:inserted_at)
    |> select([r, p], p)
    |> Repo.one()
  end

  def edit(conn, %{"id" => id}) do
    person = Organization.get_person!(id)
    people = Organization.list_people()
    changeset = Organization.change_person(person)
    render(conn, "edit.html", person: person, changeset: changeset, people: people)
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    person = Organization.get_person!(id)
    mentor_name = Map.get(person_params, "mentor")
    supervisor_name = Map.get(person_params, "supervisor")

    case Organization.update_person(person, person_params) do
      {:ok, person} ->
        create_relationship(person, mentor_name, "mentor")
        create_relationship(person, supervisor_name, "supervisor")

        conn
        |> put_flash(:info, "Person updated successfully.")
        |> redirect(to: person_path(conn, :show, person))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", person: person, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = Organization.get_person!(id)
    {:ok, _person} = Organization.delete_person(person)

    conn
    |> put_flash(:info, "Person deleted successfully.")
    |> redirect(to: person_path(conn, :index))
  end
end
