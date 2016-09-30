defmodule AdStock.TransactionServer do
  use GenServer
  import Ecto.Query

  @click_impression_stock_quantity -3
  @view_impression_stock_quantity  -1
  @stock_purchase_quantity         10

  @stock_purchase_price_change 5
  @stock_click_price_change    -10
  @stock_view_price_change     1

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, %{}}
  end

  def log_impression(stock_id, lawyer_id, impression_type) do
    GenServer.call(__MODULE__, {:impression, [impression_type, stock_id, lawyer_id]})
  end

  def create_purchase(stock_id, lawyer_id, quantity) do
    GenServer.call(__MODULE__, {:create_purchase, [stock_id, lawyer_id, quantity]})
  end

  def handle_call({:create_purchase, [stock_id, lawyer_id, quantity]}, _from, state) do
    {state, stock} = find_stock(state, stock_id)
    lawyer = AdStock.Repo.get!(AdStock.Lawyer, lawyer_id)
    {response, state} = 
      if validate_stock_purchase(stock, lawyer, quantity) do
        {:ok, [lawyer_stock, quantity]} = purchase_stock(stock, lawyer, quantity)
        {:ok, transaction} = create_transaction(:purchase, stock, quantity)
        new_state = update_stock(:purchase, stock, quantity, state)
        {{:ok, lawyer_stock}, new_state}
      else
        {{:error, "Insufficient balance or not enough stock available"}, state}
      end
    {:reply, response, state}
  end

  def handle_call({:impression, [type, stock_id, lawyer_id]}, _from, state) do
    {state, stock} = find_stock(state, stock_id)

    quantity =
      case type do
        :click -> @click_impression_stock_quantity
        :view -> @view_impression_stock_quantity
      end

    dock_impression(lawyer_id, stock, quantity)
    {:ok, _} = create_transaction(type, stock, quantity)
    state = update_stock(type, stock, quantity, state)
    {:reply, :ok, state}
  end

  defp create_transaction(type, stock, quantity) do
    transaction = Ecto.build_assoc(stock, :transactions, %{
      volume: stock.total_volume - stock.purchased_volume,
      quantity: quantity,
      type: type,
      price: stock.current_price
      })
    {:ok, transaction} = AdStock.Repo.insert(transaction)
    AdStock.Endpoint.broadcast("stock:" <> "#{stock.id}", "update", Map.from_struct(transaction) |> Map.drop([:__meta__, :stock, :lawyer]))
    {:ok, transaction}
  end

  defp update_stock(type, stock, quantity, state) do
    price_change =
      case type do
        :purchase -> @stock_purchase_price_change * quantity
        :click -> @stock_click_price_change * quantity
        :view -> @stock_view_price_change * quantity
      end
    new_price = if stock.current_price + price_change > stock.minimum_price do
      stock.current_price + price_change
    else
      stock.minimum_price
    end
    IO.inspect({price_change, new_price})
    stock_changes = %{
      purchased_volume: stock.purchased_volume + quantity,
      current_price: new_price,
    }
    {:ok, stock} = AdStock.Stock.changeset(stock, stock_changes) |> AdStock.Repo.update()
    Map.put(state, stock.id, stock)
  end

  defp dock_impression(lawyer_id, stock, quantity) do
    AdStock.Repo.get(AdStock.Lawyer, lawyer_id) 
    |> update_lawyer_stock(stock, quantity)
  end

  defp update_lawyer_stock(nil, stock, quantity) do
    AdStock.Repo.all(AdStock.Lawyer) 
    |> Enum.shuffle
    |> hd
    |> update_lawyer_stock(stock, quantity)
  end
  defp update_lawyer_stock(lawyer, stock, quantity) do
    lawyer = lawyer |> AdStock.Repo.preload([:lawyer_stocks])
    lawyer_stock = Enum.find(lawyer.lawyer_stocks, nil, fn(lawyer_stock) -> lawyer_stock.stock_id == stock.id end)
    if lawyer_stock do
      new_quantity = if lawyer_stock.quantity < quantity, do: 0, else: lawyer_stock.quantity - quantity
      AdStock.Repo.update(AdStock.LawyerStock.changeset(lawyer_stock, %{quantity: new_quantity}))
    end
    :ok
  end

  defp purchase_stock(stock, lawyer, quantity) do
    lawyer = AdStock.Repo.preload(lawyer, [:lawyer_stocks])
    lawyer_stock = Enum.find(lawyer.lawyer_stocks, nil, fn(lawyer_stock) -> lawyer_stock.stock_id == stock.id end)

    cost = stock.current_price * (quantity / @stock_purchase_quantity)
    AdStock.Lawyer.changeset(lawyer, %{current_balance: lawyer.current_balance - cost})
    |> AdStock.Repo.update()

    {:ok, lawyer_stock} = change_lawyer_stock_quantity(lawyer_stock, lawyer, stock, quantity)
    {:ok, [lawyer_stock, quantity]}
  end

  @spec change_lawyer_stock_quantity(%AdStock.LawyerStock{}, %AdStock.Lawyer{}, %AdStock.Stock{}, integer) :: {:ok, %AdStock.LawyerStock{}}
  defp change_lawyer_stock_quantity(nil, lawyer, stock, quantity) do
    Ecto.build_assoc(lawyer, :lawyer_stocks, %{stock: stock, quantity: quantity})
    |> AdStock.Repo.insert()
  end
  defp change_lawyer_stock_quantity(lawyer_stock, _, _, quantity) do
    new_quantity = lawyer_stock.quantity + quantity
    AdStock.LawyerStock.changeset(lawyer_stock, %{quantity: new_quantity})
    |> AdStock.Repo.update()
  end

  defp find_stock(state, stock_id) do
    Map.get(state, stock_id)
    |> add_stock(stock_id, state)
  end

  @spec add_stock(%AdStock.Stock{}, integer, list) :: {[%AdStock.Stock{}], %AdStock.Stock{}}
  defp add_stock(nil, stock_id, state) do
    stock = AdStock.Repo.get!(AdStock.Stock, stock_id)
    {Map.put(state, stock.id, stock), stock}
  end
  defp add_stock(stock, _, state), do: {state, stock}

  defp validate_stock_purchase(stock, lawyer, quantity) do
    stock.current_price * (quantity / @stock_purchase_quantity) < lawyer.current_balance && quantity + stock.purchased_volume < stock.total_volume
  end
end
