defmodule AdStock.Repo.Migrations.AddStockIdToTransaction do
  use Ecto.Migration

  def change do
    alter_table(:transactions) do
      add :stock_id, :integer
    end
  end
end
