defmodule Wol.Organization do
  @moduledoc """
  The Organization context.
  """

  import Ecto.Query, warn: false
  alias Wol.Repo

  alias Wol.Organization.Person

  @doc """
  Returns the list of people.

  ## Examples

      iex> list_people()
      [%Person{}, ...]

  """
  def list_people do
    Repo.all(Person)
  end

  @doc """
  Gets a single person.

  Raises `Ecto.NoResultsError` if the Person does not exist.

  ## Examples

      iex> get_person!(123)
      %Person{}

      iex> get_person!(456)
      ** (Ecto.NoResultsError)

  """
  def get_person!(id), do: Repo.get!(Person, id)

  @doc """
  Creates a person.

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_person(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a person.

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_person(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Person.

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  def delete_person(%Person{} = person) do
    Repo.delete(person)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking person changes.

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{source: %Person{}}

  """
  def change_person(%Person{} = person) do
    Person.changeset(person, %{})
  end

  alias Wol.Organization.Iteration

  @doc """
  Returns the list of iterations.

  ## Examples

      iex> list_iterations()
      [%Iteration{}, ...]

  """
  def list_iterations do
    Repo.all(Iteration)
  end

  @doc """
  Gets a single iteration.

  Raises `Ecto.NoResultsError` if the Iteration does not exist.

  ## Examples

      iex> get_iteration!(123)
      %Iteration{}

      iex> get_iteration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_iteration!(id), do: Repo.get!(Iteration, id)

  @doc """
  Creates a iteration.

  ## Examples

      iex> create_iteration(%{field: value})
      {:ok, %Iteration{}}

      iex> create_iteration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_iteration(attrs \\ %{}) do
    %Iteration{}
    |> Iteration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a iteration.

  ## Examples

      iex> update_iteration(iteration, %{field: new_value})
      {:ok, %Iteration{}}

      iex> update_iteration(iteration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_iteration(%Iteration{} = iteration, attrs) do
    iteration
    |> Iteration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Iteration.

  ## Examples

      iex> delete_iteration(iteration)
      {:ok, %Iteration{}}

      iex> delete_iteration(iteration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_iteration(%Iteration{} = iteration) do
    Repo.delete(iteration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking iteration changes.

  ## Examples

      iex> change_iteration(iteration)
      %Ecto.Changeset{source: %Iteration{}}

  """
  def change_iteration(%Iteration{} = iteration) do
    Iteration.changeset(iteration, %{})
  end

  alias Wol.Organization.PairIteration

  @doc """
  Returns the list of pair_iterations.

  ## Examples

      iex> list_pair_iterations()
      [%PairIteration{}, ...]

  """
  def list_pair_iterations do
    Repo.all(PairIteration)
  end

  def list_pair_iterations(true) do
    PairIteration
    |> join(:inner, [pi], p1 in Person, pi.person1_id == p1.id)
    |> join(:inner, [pi, p1], p2 in Person, pi.person2_id == p2.id)
    |> select([pi, p1, p2], {pi.iteration_id, p1.name, p2.name, pi.id})
    |> Repo.all()
  end

  @doc """
  Gets a single pair_iteration.

  Raises `Ecto.NoResultsError` if the Pair iteration does not exist.

  ## Examples

      iex> get_pair_iteration!(123)
      %PairIteration{}

      iex> get_pair_iteration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pair_iteration!(id), do: Repo.get!(PairIteration, id)

  @doc """
  Creates a pair_iteration.

  ## Examples

      iex> create_pair_iteration(%{field: value})
      {:ok, %PairIteration{}}

      iex> create_pair_iteration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pair_iteration(attrs \\ %{}) do
    %PairIteration{}
    |> PairIteration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pair_iteration.

  ## Examples

      iex> update_pair_iteration(pair_iteration, %{field: new_value})
      {:ok, %PairIteration{}}

      iex> update_pair_iteration(pair_iteration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pair_iteration(%PairIteration{} = pair_iteration, attrs) do
    pair_iteration
    |> PairIteration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a PairIteration.

  ## Examples

      iex> delete_pair_iteration(pair_iteration)
      {:ok, %PairIteration{}}

      iex> delete_pair_iteration(pair_iteration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pair_iteration(%PairIteration{} = pair_iteration) do
    Repo.delete(pair_iteration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pair_iteration changes.

  ## Examples

      iex> change_pair_iteration(pair_iteration)
      %Ecto.Changeset{source: %PairIteration{}}

  """
  def change_pair_iteration(%PairIteration{} = pair_iteration) do
    PairIteration.changeset(pair_iteration, %{})
  end

  def get_current_iteration() do
    Iteration
    |> last(:inserted_at)
    |> Repo.one
  end

  def is_paired?(person) do
    person_id = person.id
    iteration_id = get_current_iteration().id

    query = from pi in PairIteration,
      where: (
        pi.iteration_id == ^iteration_id
      ) and
      (
        pi.person1_id == ^person_id or
        pi.person2_id == ^person_id
      ),
      select: count(pi.id)

    Repo.one(query) > 0
  end

  def paired_person_ids() do
    query = from pi in PairIteration,
      where: pi.iteration_id == ^get_current_iteration().id,
      select: {pi.person1_id, pi.person2_id}

    query
    |> Repo.all()
    |> Enum.reduce([], fn({x, y}, acc) -> acc ++ [x] ++ [y] end)
  end

  def load_relatives(person) do
    query1 = from r in Wol.Organization.Relationship,
      where: r.person1_id == ^person.id,
      select: r.person2_id

    query2 = from r in Wol.Organization.Relationship,
      where: r.person2_id == ^person.id,
      select: r.person1_id

    Repo.all(query1) ++ Repo.all(query2)
  end

  def is_unrelated?(%Person{id: id}, %Person{id: id}), do: false

  def is_unrelated?(person, potential_relative) do
    person_id = person.id
    pr_id = potential_relative.id

    query = from r in Wol.Organization.Relationship,
      where: (
        r.person1_id == ^person_id and
        r.person2_id == ^pr_id
      ) or
      (
        r.person1_id == ^pr_id and
        r.person2_id == ^person_id
      ),
      select: count(r.id)

    Repo.one(query) == 0
  end
end
