defmodule AdStock.Repo.Migrations.CreateLawyer do
  use Ecto.Migration

  def change do
    create table(:lawyers) do
      add :lawyer_id, :integer
      add :current_balance, :integer

      timestamps()
    end

  end
end
