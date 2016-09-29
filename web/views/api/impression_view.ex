defmodule AdStock.API.ImpressionView do
  use AdStock.Web, :view

  alias AdStock.API.ImpressionView

  def render("update.json", %{type: type, sales_region_id: sales_region_id, specialty_id: specialty_id, lawyer_id: lawyer_id}) do
    %{success: true, type: type, sales_region_id: sales_region_id, specialty_id: specialty_id, lawyer_id: lawyer_id}
  end

end
