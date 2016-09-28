defmodule AdStock.Router do
  use AdStock.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdStock do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", AdStock.API do
    pipe_through :api
    get "/ping", PingController, :index
    resources "/lawyers", LawyerController, only: [:index, :show]
    resources "/stocks", StockController, only: [:index]
    resources "/transactions", TransactionController, only: [:index, :show]
  end
end
