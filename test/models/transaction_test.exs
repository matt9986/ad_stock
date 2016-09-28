defmodule AdStock.TransactionTest do
  use AdStock.ModelCase

  alias AdStock.Transaction

  @valid_attrs %{lawyer_id: 42, price: 42, quantity: 42, transaction_type: "some content", volume: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Transaction.changeset(%Transaction{}, @invalid_attrs)
    refute changeset.valid?
  end
end
