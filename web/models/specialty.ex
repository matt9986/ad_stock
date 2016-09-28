defmodule AdStock.Specialty do
  use AdStock.Web, :model

  schema "specialty" do
    field :specialty_id, :integer
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:specialty_id, :name])
    |> validate_required([:specialty_id, :name])
  end
end
