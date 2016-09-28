defmodule AdStock.TransactionControllerTest do
  use AdStock.ConnCase

  alias AdStock.Transaction
  @valid_attrs %{lawyer_id: 42, price: 42, quantity: 42, transaction_type: "some content", volume: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, transaction_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    transaction = Repo.insert! %Transaction{}
    conn = get conn, transaction_path(conn, :show, transaction)
    assert json_response(conn, 200)["data"] == %{"id" => transaction.id,
      "lawyer_id" => transaction.lawyer_id,
      "volume" => transaction.volume,
      "quantity" => transaction.quantity,
      "transaction_type" => transaction.transaction_type,
      "price" => transaction.price}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, transaction_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, transaction_path(conn, :create), transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    transaction = Repo.insert! %Transaction{}
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Transaction, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    transaction = Repo.insert! %Transaction{}
    conn = put conn, transaction_path(conn, :update, transaction), transaction: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    transaction = Repo.insert! %Transaction{}
    conn = delete conn, transaction_path(conn, :delete, transaction)
    assert response(conn, 204)
    refute Repo.get(Transaction, transaction.id)
  end
end
