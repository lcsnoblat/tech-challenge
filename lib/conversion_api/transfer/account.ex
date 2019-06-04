defmodule ConversionApi.Transfer.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :balance, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :balance])
    |> validate_required([:balance])
    |> validate_number(:balance, greater_than: 0)
  end
end
