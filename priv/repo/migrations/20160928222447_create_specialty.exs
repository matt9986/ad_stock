defmodule AdStock.Repo.Migrations.CreateSpecialty do
  use Ecto.Migration

  def change do
    create table(:specialty) do
      add :specialty_id, :integer
      add :name, :string

      timestamps()
    end

  end
end
