defmodule AdStock.API.PingView do
  use AdStock.Web, :view

  def render("index.json", _garbage) do
    %{ping: "pong"}
  end
end
