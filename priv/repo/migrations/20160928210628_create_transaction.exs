defmodule AdStock.Repo.Migrations.CreateTransaction do
  use Ecto.Migration

  def change do
    create table(:transaction) do
      add :lawyer_id, :integer
      add :volume, :integer
      add :quantity, :integer
      add :transaction_type, :string
      add :price, :integer

      timestamps()
    end

  end
end
