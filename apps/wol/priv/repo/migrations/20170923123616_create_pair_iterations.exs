defmodule Wol.Repo.Migrations.CreatePairIterations do
  use Ecto.Migration

  def change do
    create table(:pair_iterations) do
      add :person1_id, :integer
      add :person2_id, :integer
      add :iteration_id, :integer
      add :restaurant, :string
      add :restaurant_details, :string
      add :rating, :integer
      add :comments, :text

      timestamps()
    end

  end
end
