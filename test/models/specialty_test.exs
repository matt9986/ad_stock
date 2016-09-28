defmodule AdStock.SpecialtyTest do
  use AdStock.ModelCase

  alias AdStock.Specialty

  @valid_attrs %{name: "some content", specialty_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Specialty.changeset(%Specialty{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Specialty.changeset(%Specialty{}, @invalid_attrs)
    refute changeset.valid?
  end
end
