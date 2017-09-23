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
end
