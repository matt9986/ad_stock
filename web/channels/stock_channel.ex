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
      stub_transaction(hour: 0, price: 1),
      stub_transaction(hour: 1, price: 2),
      stub_transaction(hour: 2, price: 3),
      stub_transaction(hour: 3, price: 4),
      stub_transaction(hour: 4, price: 5),
      stub_transaction(hour: 5, price: 4),
      stub_transaction(hour: 6, price: 3),
      stub_transaction(hour: 7, price: 4),
      stub_transaction(hour: 8, price: 5),
      stub_transaction(hour: 9, price: 6),
      stub_transaction(hour: 10, price: 7),
      stub_transaction(hour: 11, price: 8),
      stub_transaction(hour: 12, price: 7),
      stub_transaction(hour: 13, price: 6),
      stub_transaction(hour: 14, price: 7),
      stub_transaction(hour: 15, price: 8),
      stub_transaction(hour: 16, price: 9)
    ]}
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
