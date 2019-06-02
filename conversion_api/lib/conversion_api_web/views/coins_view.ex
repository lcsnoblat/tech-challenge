defmodule ConversionApiWeb.CoinsView do
  use ConversionApiWeb, :view
  alias ConversionApiWeb.CoinsView

  def render("index.json", %{coins: coins}) do
    %{data: render_many(coins, CoinsView, "coins.json")}
  end

  def render("show.json", %{coins: coins}) do
    %{data: render_one(coins, CoinsView, "coins.json")}
  end

  def render("coins.json", %{coins: coins}) do
    %{id: coins.id,
      name: coins.name,
      rate: coins.rate}
  end
end
