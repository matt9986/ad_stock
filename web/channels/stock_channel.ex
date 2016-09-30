defmodule AdStock.StockChannel do
  use AdStock.Web, :channel

  alias AdStock.StockSeed

  def join("stock:" <> stock_id, payload, socket) do
    if authorized?(payload) do
      assign(socket, :stock_id, stock_id)
      send(self, {:after_join, stock_id})
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_info({:after_join, stock_id}, socket) do
    history = StockSeed.get_history(stock_id)
    push socket, "history", %{"history": history}
    {:noreply, socket}
  end

  defp stub_transaction([hour: hour, price: price]) do
    {date, _} = :calendar.local_time()
    date_time = Ecto.DateTime.from_erl({date, {hour, 1, 0}})
    %{inserted_at: Ecto.DateTime.to_iso8601(date_time), price: price}
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
