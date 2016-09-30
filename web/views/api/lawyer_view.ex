defmodule AdStock.API.LawyerView do
  use AdStock.Web, :view

  alias AdStock.API.LawyerView

  def render("index.json", %{lawyers: lawyers}) do
    %{lawyers: render_many(lawyers, LawyerView, "lawyer.json")}
  end

  def render("show.json", %{lawyer: lawyer}) do
    %{lawyers: render_many([lawyer], LawyerView, "lawyer.json")}
  end

  def render("lawyer.json", %{lawyer: lawyer}) do
    %{
      id: lawyer.id,
      name: lawyer.name,
      current_balance: lawyer.current_balance,
      updated_at: lawyer.updated_at,
    }
  end
end
