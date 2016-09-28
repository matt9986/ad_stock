defmodule AdStock.SpecialtySeed do

  @specialty_ids [56,84,95,87,82,112,43,55,63,86]
  @sales_region_ids [3329]
  
  @specialties_base_url "http://solicitorstag.corp.avvo.com/api/2/specialties/"

  alias AdStock.Specialty
  alias AdStock.Repo

  def run() do
    Repo.delete_all(Specialty)
    Enum.each(@specialty_ids, fn(specialty_id) -> 
      specialty_data = Tesla.get("#{@specialties_base_url}#{specialty_id}.json").body
      |> Poison.decode! 
      |> Map.get("specialties") 
      |> hd
      specialty = %Specialty{specialty_id: Map.get(specialty_data, "id"), name: Map.get(specialty_data, "name")} |> Specialty.changeset
      Repo.insert!(specialty)
    end)
  end
end
