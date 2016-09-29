defmodule AdStock.Lawyer do
  use AdStock.Web, :model

  schema "lawyers" do
    field :lawyer_id, :integer
    field :name, :string
    field :current_balance, :integer

    has_many :lawyer_stocks, AdStock.LawyerStock
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:lawyer_id, :current_balance])
    |> validate_required([:lawyer_id, :current_balance])
  end
end
