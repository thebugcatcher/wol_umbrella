defmodule Wol.Repo.Migrations.CreateOrganizationRelationships do
  use Ecto.Migration

  def change do
    create table(:organization_relationships) do
      add :person1_id, :integer
      add :person2_id, :integer
      add :relationship_type, :string

      timestamps()
    end

  end
end
