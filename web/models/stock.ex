defmodule AdStock.Stock do
  use AdStock.Web, :model

  schema "stocks" do
    field :specialty_id, :integer
    field :name, :string
    field :sales_region_id, :integer
    field :total_volume, :integer
    field :current_price, :integer
    field :minimum_price, :integer
    field :purchased_volume, :integer

    has_many :transactions, AdStock.Transaction
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:specialty_id, :name, :sales_region_id, :total_volume, :current_price, :minimum_price, :purchased_volume])
    |> validate_required([:specialty_id, :name, :sales_region_id, :total_volume, :current_price, :minimum_price, :purchased_volume])
  end
end
