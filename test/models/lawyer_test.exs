defmodule AdStock.LawyerTest do
  use AdStock.ModelCase

  alias AdStock.Lawyer

  @valid_attrs %{current_balance: 42, lawyer_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Lawyer.changeset(%Lawyer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Lawyer.changeset(%Lawyer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
