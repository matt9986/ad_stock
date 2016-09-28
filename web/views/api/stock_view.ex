defmodule AdStock.API.StockView do
  use AdStock.Web, :view

  alias AdStock.API.StockView

  def render("index.json", %{stocks: stocks}) do
    %{stocks: render_many(stocks, StockView, "stock.json")}
  end

  def render("stock.json", %{stock: stock}) do
    %{
      id: stock.id,
      name: stock.name,
      specialty_id: stock.specialty_id,
      sales_region_id: stock.sales_region_id,
      total_volume: stock.total_volume,
      purchased_volume: stock.purchased_volume,
      minimum_price: stock.minimum_price,
      current_price: stock.current_price,
      updated_at: stock.updated_at,
    }
  end
end
