defmodule AdStock.API.PingController do
  use AdStock.Web, :controller

  def index(conn, params) do
    render(conn, "index.json")
  end
end