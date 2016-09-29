defmodule AdStock.LawyerStockTest do
  use AdStock.ModelCase

  alias AdStock.LawyerStock

  @valid_attrs %{quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LawyerStock.changeset(%LawyerStock{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LawyerStock.changeset(%LawyerStock{}, @invalid_attrs)
    refute changeset.valid?
  end
end
