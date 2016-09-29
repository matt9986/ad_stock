defmodule AdStock.Transaction do
  use AdStock.Web, :model

  schema "transaction" do
    field :lawyer_id, :integer
    field :volume, :integer
    field :quantity, :integer
    field :transaction_type, :string
    field :price, :integer

    belongs_to :stock, AdStock.Stock

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:lawyer_id, :volume, :quantity, :transaction_type, :price])
    |> validate_required([:lawyer_id, :volume, :quantity, :transaction_type, :price])
  end
end
