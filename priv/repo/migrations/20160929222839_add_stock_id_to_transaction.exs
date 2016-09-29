defmodule AdStock.Repo.Migrations.AddStockIdToTransaction do
  use Ecto.Migration

  def change do
    alter table(:transaction) do
      add :stock_id, :integer
    end
  end
end
