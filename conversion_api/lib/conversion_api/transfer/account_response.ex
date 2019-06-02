defmodule ConversionApi.Transfer.AccountResponse do
  use Ecto.Schema

  schema "accountsResponse" do
    field :balance, :integer
    field :name, :string
  end
end