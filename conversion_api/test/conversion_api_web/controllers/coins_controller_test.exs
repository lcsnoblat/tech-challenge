defmodule ConversionApiWeb.CoinsControllerTest do
  use ConversionApiWeb.ConnCase

  alias ConversionApi.Directory
  alias ConversionApi.Directory.Coins

  @create_attrs %{
    name: "some name",
    rate: 42
  }
  @update_attrs %{
    name: "some updated name",
    rate: 43
  }
  @invalid_attrs %{name: nil, rate: nil}

  def fixture(:coins) do
    {:ok, coins} = Directory.create_coins(@create_attrs)
    coins
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all coins", %{conn: conn} do
      conn = get(conn, Routes.coins_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create coins" do
    test "renders coins when data is valid", %{conn: conn} do
      conn = post(conn, Routes.coins_path(conn, :create), coins: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.coins_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "rate" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.coins_path(conn, :create), coins: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update coins" do
    setup [:create_coins]

    test "renders coins when data is valid", %{conn: conn, coins: %Coins{id: id} = coins} do
      conn = put(conn, Routes.coins_path(conn, :update, coins), coins: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.coins_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "rate" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, coins: coins} do
      conn = put(conn, Routes.coins_path(conn, :update, coins), coins: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete coins" do
    setup [:create_coins]

    test "deletes chosen coins", %{conn: conn, coins: coins} do
      conn = delete(conn, Routes.coins_path(conn, :delete, coins))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.coins_path(conn, :show, coins))
      end
    end
  end

  defp create_coins(_) do
    coins = fixture(:coins)
    {:ok, coins: coins}
  end
end
