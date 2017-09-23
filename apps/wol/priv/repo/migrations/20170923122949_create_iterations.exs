defmodule Wol.Repo.Migrations.CreateIterations do
  use Ecto.Migration

  def change do
    create table(:iterations) do
      add :end_date, :date

      timestamps()
    end

  end
end
