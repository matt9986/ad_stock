defmodule AdStock.StockController do
  use AdStock.Web, :controller

  def show(conn, %{"id" => id}) do
    stock = AdStock.Repo.get(AdStock.Stock, id |> String.to_integer)
    render conn, "show.html", stock: stock
  end
end
