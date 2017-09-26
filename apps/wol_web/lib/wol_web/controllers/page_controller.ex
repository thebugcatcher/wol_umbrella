defmodule WolWeb.PageController do
  use WolWeb, :controller

  import WolWeb.PageFilters

  alias Wol.Organization, as: Org
  alias ListFilterer, as: Filterer

  def index(conn, params) do
    {:ok, iteration} = IterationsManager.check_iteration()

    people = Org.list_people()
      |> Filterer.filter(index_filters())

    {queryable, rummage} = Org.Person
      |> Rummage.Ecto.rummage(params["rummage"])

    rummaged = Wol.Repo.all(queryable)

    render conn,
      "index.html",
      people: people,
      person: :nil,
      iteration: iteration
  end

  def about(conn, _params) do
    render conn, "about.html"
  end

  def first_select(conn, %{"name" => person_name} = params) do
    person = Wol.Repo.get_by!(Org.Person, [name: person_name])

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
      "person2_selector.html",
      people: people,
      person: person,
      iteration: iteration
  end

  def second_select(conn, %{"name" => person_name, "second" => second_person_name}) do
    person1 = Wol.Repo.get_by!(Org.Person, [name: person_name])
    person2 = Wol.Repo.get_by!(Org.Person, [name: second_person_name])

    iteration = Org.get_current_iteration()

    attrs = %{
      person1_id: person1.id,
      person2_id: person2.id,
      iteration_id: iteration.id
    }

    case Org.create_pair_iteration(attrs) do
      {:ok, _} ->
        try do
          #Emailer.send_pair_notification([person1, person2])
        rescue
          _ -> :ok
        end

        conn
        |> put_flash(:info, "Paired: #{person1.name} & #{person2.name}")
        |> redirect(to: page_path(conn, :index))
      {:error, _} ->
        conn
        |> assign(:person, nil)
        |> put_flash(:error, "Unexpected Error! Try again.")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def pair_generator(conn, _params) do
    render conn, "pair_generator.html"
  end

  def generate_pairs(conn, %{"generate" => %{"num" => num}}) do
    all_people = Org.list_people()
    num = String.to_integer(num)

    text = 1..num
      |> Enum.map(fn(_x) ->
        people = all_people
          |> Filterer.filter(index_filters())

        person1 = Enum.random(people)

        {:ok, iteration} = IterationsManager.check_iteration()

        people = all_people
          |> Filterer.filter(first_select_filters(person1))

        people = case Enum.count(people) do
          0 -> all_people
            |> Filterer.filter(second_chance_filters(person1))
          _ -> people
        end

        person2 = Enum.random(people)

        attrs = %{
          person1_id: person1.id,
          person2_id: person2.id,
          iteration_id: iteration.id
        }

        Org.create_pair_iteration(attrs)

        try do
          #Emailer.send_pair_notification([person1, person2])
        rescue
          _ -> :ok
        end

        {person1.name, person2.name}
    end)
    |> Enum.reduce("Pairs: ", fn({p1, p2}, acc) -> acc <> "{#{p1}, #{p2}}, " end)
    |> String.trim_trailing(", ")

    conn
    |> put_flash(:info, text)
    |> redirect(to: page_path(conn, :index))
  end
end
