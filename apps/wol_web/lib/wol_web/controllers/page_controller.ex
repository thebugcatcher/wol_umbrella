defmodule WolWeb.PageController do
  use WolWeb, :controller

  import WolWeb.PageFilters

  alias Wol.Organization, as: Org
  alias ListFilterer, as: Filterer

  def index(conn, params) do
    people = Org.list_people()
      |> Filterer.filter(index_filters())

    {:ok, iteration} = IterationsManager.check_iteration()

    {queryable, rummage} = Org.Person
      |> Rummage.Ecto.rummage(params["rummage"])

    rummaged = Wol.Repo.all(queryable)

    render conn,
      "index.html",
      spin1_people: people,
      spin2_people: [],
      rummage: rummage,
      rummaged: rummaged,
      iteration: iteration
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def first_select(conn, %{"id" => person_id} = params) do
    person = Org.get_person!(person_id)
    conn = put_session(conn, :person_id, person.id)

    {:ok, iteration} = IterationsManager.check_iteration()

    all_people = Org.list_people()

    people = all_people
      |> Filterer.filter(first_select_filters(person))

    people = case Enum.count(people) do
      0 -> all_people
        |> Filterer.filter(second_chance_filters(person))
      _ -> people
    end

    {queryable, rummage} = Org.Person
      |> Rummage.Ecto.rummage(params["rummage"])

    rummaged = Wol.Repo.all(queryable)

    render conn,
      "index.html",
      spin1_people: {:done, person},
      spin2_people: people,
      rummage: rummage,
      rummaged: rummaged,
      iteration: iteration
  end

  def second_select(conn, %{"id" => person_id}) do
    person2 = Org.get_person!(person_id)
    person1 = conn
      |> get_session(:person_id)
      |> Org.get_person!()

    iteration = Org.get_current_iteration()

    attrs = %{
      person1_id: person1.id,
      person2_id: person2.id,
      iteration_id: iteration.id
    }

    case Org.create_pair_iteration(attrs) do
      {:ok, _} ->
        conn
        |> assign(:person, nil)
        |> put_flash(:info, "Paired: #{person1.name} & #{person2.name}")
        |> redirect(to: page_path(conn, :index))
      {:error, _} ->
        conn
        |> assign(:person, nil)
        |> put_flash(:error, "Unexpected Error! Try again.")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
