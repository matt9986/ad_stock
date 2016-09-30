defmodule AdStock.PageController do
  use AdStock.Web, :controller

  def index(conn, _params) do
    lawyers = AdStock.Repo.all(AdStock.Lawyer)
    stocks = AdStock.Repo.all(AdStock.Stock)
    render conn, "index.html", %{stocks: stocks, lawyers: lawyers}
  end
end
