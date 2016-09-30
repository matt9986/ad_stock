defmodule AdStock.StockSeed do

  @sales_region_id 3329
  @quasi_base_url "http://localhost:5001/api/v1/ad_inventories?sales_region_id=#{@sales_region_id}&ad_type=SL&specialty_id="

  alias AdStock.Stock
  alias AdStock.Specialty
  alias AdStock.Repo

  import Ecto.Query

  def run() do
    Repo.delete_all(Stock)
    specialties = Repo.all(Specialty)
    Enum.each(specialties, fn(specialty) -> 
      inventory = Tesla.get("#{@quasi_base_url}#{specialty.specialty_id}") 
      |> Map.get(:body)
      |> Poison.decode! 
      |> Map.get("ad_inventories")
      |> hd
      stock = %Stock{specialty_id: specialty.specialty_id, 
        name: specialty.name, 
        sales_region_id: @sales_region_id,
        minimum_price: 1,
        total_volume: Map.get(inventory, "search_count"),
        purchased_volume: 0,
        current_price: (Map.get(inventory, "list_price") / Map.get(inventory, "search_count") * 10) |> round
      }
      Repo.insert!(stock)
    end)
  end

  def get_history(stock_id) do
    history = Repo.all(from t in "transaction",
      select: [:price],
      where: t.stock_id == ^stock_id)
     
  end
end
