defmodule Wol.Repo.Migrations.CreatePairIterations do
  use Ecto.Migration

  def change do
    create table(:pair_iterations) do
      add :person1_id, :integer
      add :person2_id, :integer
      add :iteration_id, :integer

      timestamps()
    end

  end
end
