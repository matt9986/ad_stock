defmodule AdStock.API.PurchaseView do
  use AdStock.Web, :view

  alias AdStock.API.PurchaseView

  def render("create.json", %{response: {:ok, lawyer_stock}}) do
    %{lawyers: render_many([lawyer_stock], PurchaseView, "lawyer_stock.json")}
  end

  def render("create.json", %{response: {:error, message}}) do
    %{error: message}
  end

  def render("lawyer_stock.json", %{purchase: lawyer_stock}) do
    %{
      id: lawyer_stock.id,
      lawyer_id: lawyer_stock.lawyer_id,
      stock_id: lawyer_stock.stock_id,
      quantity: lawyer_stock.quantity,
    }
  end
end
