defmodule AdStock.API.TransactionController do
  use AdStock.Web, :controller

  alias AdStock.Transaction

  def index(conn, _params) do
    transaction = Repo.all(Transaction)
    render(conn, "index.json", transaction: transaction)
  end

  def show(conn, %{"id" => id}) do
    transaction = Repo.get!(Transaction, id)
    render(conn, "show.json", transaction: transaction)
  end

end
