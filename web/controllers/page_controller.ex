defmodule AdStock.PageController do
  use AdStock.Web, :controller

  def index(conn, _params) do
    stocks = AdStock.Repo.all(AdStock.Stock)
    render conn, "index.html", stocks: stocks
  end
end
