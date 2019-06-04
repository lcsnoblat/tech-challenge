defmodule ConversionApiWeb.AccountControllerTest do
  use ConversionApiWeb.ConnCase

  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account

  @create_attrs %{
    balance: 40,
    name: "some name"
  }
  @create_another_attrs %{
    balance: 80,
    name: "some some name"
  }
  @update_attrs %{
    balance: 43,
    name: "some updated name"
  }
  @transfer_attrs %{
    from: 1,
    to: 2,
    value: 1
  }
  @invalid_attrs %{balance: nil, name: nil}

  def fixture(:account) do
    {:ok, account} = Transfer.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, Routes.account_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.account_path(conn, :show, id))

      assert %{
               "id" => id,
               "balance" => 40,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.account_path(conn, :create), account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "transfer money" do
    setup do
      {:ok, created_account_one} = Transfer.create_account(@create_attrs)
      {:ok, create_account_two} = Transfer.create_account(@create_another_attrs)
      %{account: created_account_one, account_two: create_account_two}
    end
      test "transfer money between two accounts", %{conn: conn, account: account, account_two: account_two} do
      account = Transfer.get_account!(account.id)
      account_two = Transfer.get_account!(account_two.id)

      conn = post(conn, Routes.account_path(conn, :transfer), %{from: account.id, to: account_two.id, value: 10})
      assert %{"transfered_value" => transfered_value, "new_balance" => new_balance} = json_response(conn, 200)

      assert transfered_value == 10
      assert new_balance == 30
    end
  end
  
  defp create_account(_) do
    account = fixture(:account)
    {:ok, account: account}
  end
end
