defmodule ConversionApiWeb.CoinsController do
  use ConversionApiWeb, :controller

  alias ConversionApi.Directory
  alias ConversionApi.Directory.Coins
  alias ConversionApiWeb.CoinService

  action_fallback ConversionApiWeb.FallbackController

  def index(conn, _params) do
    coins = Directory.list_coins()
    render(conn, "index.json", coins: coins)
  end

  def convert(conn, %{"base" => base, "target" => target, "amount" => amount}) do
    with {:ok, converted_value} <- CoinService.convert(base, target, amount) do
      conn
      |> put_status(200)
      |> render("coins.json", %{converted_value: converted_value, amount: amount})
    end
  end

  def create(conn, %{"coins" => coins_params}) do
    with {:ok, %Coins{} = coins} <- Directory.create_coins(coins_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.coins_path(conn, :show, coins))
      |> render("show.json", coins: coins)
    end
  end

  def show(conn, %{"id" => id}) do
    coins = Directory.get_coins!(id)
    render(conn, "show.json", coins: coins)
  end
end
