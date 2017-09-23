defmodule Wol.Organization.Iteration do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wol.Organization.Iteration


  schema "iterations" do
    field :end_date, :date

    timestamps()
  end

  @doc false
  def changeset(%Iteration{} = iteration, attrs) do
    iteration
    |> cast(attrs, [:end_date])
    |> validate_required([:end_date])
  end
end
