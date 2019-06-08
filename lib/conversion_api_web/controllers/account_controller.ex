defmodule ConversionApiWeb.AccountController do
  use ConversionApiWeb, :controller

  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account
  alias ConversionApiWeb.AccountService

  action_fallback ConversionApiWeb.FallbackController

  def transfer(_conn, %{"value" => value}) when is_boolean(value), do: {:error, "Você precisa informar um valor"}

  def transfer(_conn, %{"value" => value}) when not is_number(value), do: {:error, "Valor precisa ser um número"}

  def transfer(conn, %{"from" => from_account, "to" => to_account, "value" => value}) do
    with {:ok, %Account{} = account} <- AccountService.transfer(from_account, to_account, value) do
      conn
      |> put_status(200)
      |> render("transfer.json", %{account: account, transfered_value: value})
    end
  end

  def transfer(conn, %{"from" => from_account, "accounts" => accounts, "value" => value}) do
    with {:ok, %Account{} = account} <- AccountService.transfer(%{from_account: from_account, accounts: accounts, value: value}) do
      conn
      |> put_status(200)
      |> render("transfer.json", %{account: account})
    end
  end

  def index(conn, _params) do
    accounts = Transfer.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Transfer.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.account_path(conn, :show, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Transfer.get_account!(id)
    render(conn, "show.json", account: account)
  end
end
