defmodule Wol.Organization.PairIteration do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wol.Organization.PairIteration


  schema "pair_iterations" do
    field :iteration_id, :integer
    field :person1_id, :integer
    field :person2_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%PairIteration{} = pair_iteration, attrs) do
    pair_iteration
    |> cast(attrs, [:person1_id, :person2_id, :iteration_id])
    |> validate_required([:person1_id, :person2_id, :iteration_id])
  end
end
