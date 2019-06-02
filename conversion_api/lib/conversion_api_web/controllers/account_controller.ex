defmodule ConversionApiWeb.AccountController do
  use ConversionApiWeb, :controller

  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account
  alias ConversionApiWeb.AccountService

  action_fallback ConversionApiWeb.FallbackController

  def transfer(conn, %{"from" => from_account, "to" => to_account, "value" => value}) do
    with {:ok, %Account{} = account} <- AccountService.transfer(from_account, to_account, value) do
      conn
      |> put_status(200)
      |> render("account.json", %{account: account, transfered_value: value})
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

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Transfer.get_account!(id)

    with {:ok, %Account{} = account} <- Transfer.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Transfer.get_account!(id)

    with {:ok, %Account{}} <- Transfer.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
