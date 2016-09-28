defmodule AdStock.API.StockView do
  use AdStock.Web, :view

  def render("index.json", %{stocks: stocks}) do
    %{stocks: render_many(stocks, StockView, "stock.json")}
  end
end
