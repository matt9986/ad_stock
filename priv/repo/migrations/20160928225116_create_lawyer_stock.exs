defmodule AdStock.Repo.Migrations.CreateLawyerStock do
  use Ecto.Migration

  def change do
    create table(:lawyer_stocks) do
      add :quantity, :integer
      add :lawyer_id, references(:lawyers, on_delete: :nothing)
      add :stock_id, references(:stocks, on_delete: :nothing)

      timestamps()
    end
    create index(:lawyer_stocks, [:lawyer_id])
    create index(:lawyer_stocks, [:stock_id])

  end
end
