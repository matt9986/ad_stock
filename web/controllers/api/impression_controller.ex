defmodule AdStock.API.ImpressionController do
  use AdStock.Web, :controller

  def update(conn, %{"type" => type, "sales_region_id" => sales_region_id, "specialty_id" => specialty_id, "lawyer_id" => lawyer_id}) do
    stock = AdStock.Repo.get_by(AdStock.Stock, %{specialty_id: specialty_id})
    if stock do
      AdStock.TransactionServer.log_impression(stock.id, lawyer_id |> Integer.parse() |> elem(0), type |> Integer.parse() |> elem(0) |> convert_type())
    end
    render(conn, "update.json", %{type: type, sales_region_id: sales_region_id, specialty_id: specialty_id, lawyer_id: lawyer_id})    
  end

  defp convert_type(type_int) do
    case type_int do
      1 ->
        :view
      2 ->
        :click
    end
  end
end
