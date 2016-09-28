defmodule AdStock.StockTest do
  use AdStock.ModelCase

  alias AdStock.Stock

  @valid_attrs %{current_price: 42, minimum_price: 42, name: "some content", purchased_volume: 42, sales_region_id: 42, specialty_id: 42, total_volume: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stock.changeset(%Stock{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stock.changeset(%Stock{}, @invalid_attrs)
    refute changeset.valid?
  end
end
