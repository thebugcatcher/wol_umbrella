defmodule Wol.OrganizationTest do
  use Wol.DataCase

  alias Wol.Organization

  describe "people" do
    alias Wol.Organization.Person

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def person_fixture(attrs \\ %{}) do
      {:ok, person} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organization.create_person()

      person
    end

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert Organization.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Organization.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      assert {:ok, %Person{} = person} = Organization.create_person(@valid_attrs)
      assert person.email == "some email"
      assert person.name == "some name"
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organization.create_person(@invalid_attrs)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()
      assert {:ok, person} = Organization.update_person(person, @update_attrs)
      assert %Person{} = person
      assert person.email == "some updated email"
      assert person.name == "some updated name"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Organization.update_person(person, @invalid_attrs)
      assert person == Organization.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Organization.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Organization.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Organization.change_person(person)
    end
  end

  describe "iterations" do
    alias Wol.Organization.Iteration

    @valid_attrs %{end_date: ~D[2010-04-17]}
    @update_attrs %{end_date: ~D[2011-05-18]}
    @invalid_attrs %{end_date: nil}

    def iteration_fixture(attrs \\ %{}) do
      {:ok, iteration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Organization.create_iteration()

      iteration
    end

    test "list_iterations/0 returns all iterations" do
      iteration = iteration_fixture()
      assert Organization.list_iterations() == [iteration]
    end

    test "get_iteration!/1 returns the iteration with given id" do
      iteration = iteration_fixture()
      assert Organization.get_iteration!(iteration.id) == iteration
    end

    test "create_iteration/1 with valid data creates a iteration" do
      assert {:ok, %Iteration{} = iteration} = Organization.create_iteration(@valid_attrs)
      assert iteration.end_date == ~D[2010-04-17]
    end

    test "create_iteration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organization.create_iteration(@invalid_attrs)
    end

    test "update_iteration/2 with valid data updates the iteration" do
      iteration = iteration_fixture()
      assert {:ok, iteration} = Organization.update_iteration(iteration, @update_attrs)
      assert %Iteration{} = iteration
      assert iteration.end_date == ~D[2011-05-18]
    end

    test "update_iteration/2 with invalid data returns error changeset" do
      iteration = iteration_fixture()
      assert {:error, %Ecto.Changeset{}} = Organization.update_iteration(iteration, @invalid_attrs)
      assert iteration == Organization.get_iteration!(iteration.id)
    end

    test "delete_iteration/1 deletes the iteration" do
      iteration = iteration_fixture()
      assert {:ok, %Iteration{}} = Organization.delete_iteration(iteration)
      assert_raise Ecto.NoResultsError, fn -> Organization.get_iteration!(iteration.id) end
    end

    test "change_iteration/1 returns a iteration changeset" do
      iteration = iteration_fixture()
      assert %Ecto.Changeset{} = Organization.change_iteration(iteration)
    end
  end
end
