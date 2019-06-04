defmodule ConversionApiWeb.AccountView do
  use ConversionApiWeb, :view
  alias ConversionApiWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      name: account.name,
      balance: account.balance}
  end

  def render("transfer.json", %{account: account, transfered_value: transfered_value}) do
    %{
      id: account.id,
      name: account.name,
      new_balance: account.balance,
      transfered_value: transfered_value
    }
  end
end
