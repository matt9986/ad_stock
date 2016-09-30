defmodule AdStock.API.PurchaseController do
  use AdStock.Web, :controller

  def create(conn, %{"stock_id" => stock_id, "quantity" => quantity, "lawyer_id" => lawyer_id}) do
    response = AdStock.TransactionServer.create_purchase(stock_id, lawyer_id, quantity)
    render(conn, "create.json", %{response: response})
  end
end
