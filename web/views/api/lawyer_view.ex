defmodule AdStock.API.LawyerView do
  use AdStock.Web, :view

  def render("index.json", %{lawyers: lawyers}) do
    %{lawyers: render_many(lawyers, LawyerView, "lawyer.json")}
  end

  def render("show.json", %{lawyer: lawyer}) do
    %{lawyers: render_many([lawyer], LawyerView, "lawyer.json")}
  end
end
