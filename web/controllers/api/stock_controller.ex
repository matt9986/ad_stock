defmodule AdStock.API.StockController do
  use AdStock.Web, :controller

  def index(conn, params) do
    stocks = AdStock.Repo.all(from t in AdStock.Stock, limit: 100)
    render(conn, "index.json", stocks: stocks)
  end
end