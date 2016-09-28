defmodule AdStock.API.TransactionView do
  use AdStock.Web, :view

  def render("index.json", %{transaction: transaction}) do
    %{data: render_many(transaction, AdStock.TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, AdStock.TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      lawyer_id: transaction.lawyer_id,
      volume: transaction.volume,
      quantity: transaction.quantity,
      transaction_type: transaction.transaction_type,
      price: transaction.price}
  end
end
