defmodule ConversionApiWeb.AccountService do
  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account

  def transfer(from_account, to_account, value) do
    account_origin = Transfer.get_account!(from_account)
    account_destiny = Transfer.get_account!(to_account)

    with %{balance: origin_account_balance} <- subtract_balance(account_origin, value) do
      destiny_account_balance = add_balance(account_destiny, value)
      updated_origin_account = Transfer.update_account(account_origin, %{balance: origin_account_balance})
      Transfer.update_account(account_destiny, destiny_account_balance)
      updated_origin_account
    end
  end

  def transfer(%{from_account: from_account, accounts: accounts, value: value}) do
    account_origin = Transfer.get_account!(from_account)
    with %{balance: origin_account_balance} <- subtract_balance(account_origin, value) do
      updated_origin_account = Transfer.update_account(account_origin, %{balance: origin_account_balance})

      for x <- accounts do
        account = Transfer.get_account!(x)
        new_balance = add_balance(account, value / length(accounts))
        Transfer.update_account(account, new_balance)
      end
      updated_origin_account
    end
  end


  def subtract_balance(%Account{} = account_origin, value) do
    case account_origin.balance > value do
      true ->
        %{balance: account_origin.balance - value}

      false ->
        {:error, "Você não possui saldo o suficiente!"}
    end
  end

  def add_balance(%Account{} = account_destiny, value) do
    %{balance: account_destiny.balance + value}
  end
end
