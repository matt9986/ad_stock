defmodule AdStock.API.LawyerController do
  use AdStock.Web, :controller

  def index(conn, params) do
    lawyers = AdStock.Repo.all(from t in AdStock.Lawyer, limit: 30)
    render(conn, "index.json", lawyers: lawyers)
  end

  def show(conn, %{"id" => id}) do
    lawyer = Repo.get!(AdStock.Lawyer, id)
    render(conn, "show.json", lawyer: lawyer)
  end
end