defmodule AdStock.API.PurchaseController do
  use AdStock.Web, :controller

  def create(conn, %{"stock_id" => stock_id, "quantity" => quantity, "lawyer_id" => lawyer_id}) do
    response = AdStock.TransactionServer.create_purchase("#{stock_id}" |> String.to_integer(), "#{lawyer_id}" |> String.to_integer(), "#{quantity}" |> String.to_integer())
    render(conn, "create.json", %{response: response})
  end
end
