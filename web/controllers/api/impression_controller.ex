defmodule AdStock.API.ImpressionController do
  use AdStock.Web, :controller

  def update(conn, %{"type" => type, "sales_region_id" => sales_region_id, "specialty_id" => specialty_id, "lawyer_id" => lawyer_id}) do
    render(conn, "update.json", %{type: type, sales_region_id: sales_region_id, specialty_id: specialty_id, lawyer_id: lawyer_id})    
  end
end
