defmodule Wol.Organization.Relationship do
  use Ecto.Schema
  import Ecto.Changeset
  alias Wol.Organization.Relationship


  schema "organization_relationships" do
    field :person1_id, :integer
    field :person2_id, :integer
    field :relationship_type, :string

    timestamps()
  end

  @doc false
  def changeset(%Relationship{} = relationship, attrs) do
    relationship
    |> cast(attrs, [:person1_id, :person2_id, :relationship_type])
    |> validate_required([:person1_id, :person2_id, :relationship_type])
    |> validate_inclusion(:relationship_type, ["mentor", "supervisor"])
  end
end
