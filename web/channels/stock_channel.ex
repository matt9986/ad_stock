defmodule AdStock.StockChannel do
  use AdStock.Web, :channel

  def join("stock:" <> stock_id, payload, socket) do
    if authorized?(payload) do
      assign(socket, :stock_id, stock_id)
      send(self, :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info(:after_join, socket) do
    push socket, "history", %{"history": [
      %{cratedAt: DateTime.to_iso8601(DateTime.utc_now), price: 1},
      %{cratedAt: DateTime.to_iso8601(DateTime.utc_now), price: 2},
      %{cratedAt: DateTime.to_iso8601(DateTime.utc_now), price: 3}
    ]}
    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
