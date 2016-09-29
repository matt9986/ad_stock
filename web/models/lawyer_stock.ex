defmodule AdStock.LawyerStock do
  use AdStock.Web, :model

  schema "lawyer_stocks" do
    field :quantity, :integer
    belongs_to :lawyer, AdStock.Lawyer
    belongs_to :stock, AdStock.Stock

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:quantity])
    |> validate_required([:quantity])
  end
end
