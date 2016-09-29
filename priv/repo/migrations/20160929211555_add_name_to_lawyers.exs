defmodule AdStock.Repo.Migrations.AddNameToLawyers do
  use Ecto.Migration

  def change do
    alter table(:lawyers) do
      add :name, :string
    end
  end
end
