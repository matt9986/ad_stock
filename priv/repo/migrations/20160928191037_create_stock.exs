defmodule AdStock.Repo.Migrations.CreateStock do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :specialty_id, :integer
      add :name, :string
      add :sales_region_id, :integer
      add :total_volume, :integer
      add :current_price, :integer
      add :minimum_price, :integer
      add :purchased_volume, :integer

      timestamps()
    end

  end
end
