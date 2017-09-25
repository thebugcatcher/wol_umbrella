defmodule Wol.Organization.Person do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wol.Organization.Person


  schema "people" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(:name)
    |> unique_constraint(:email)
  end
end
