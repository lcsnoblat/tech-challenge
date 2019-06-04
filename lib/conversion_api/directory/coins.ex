defmodule ConversionApi.Directory.Coins do
  use Ecto.Schema
  import Ecto.Changeset

  schema "coins" do
    field :name, :string
    field :rate, :integer

    timestamps()
  end

  @doc false
  def changeset(coins, attrs) do
    coins
    |> cast(attrs, [:name, :rate])
    |> validate_required([:name, :rate])
  end
end
