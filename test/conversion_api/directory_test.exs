defmodule ConversionApi.DirectoryTest do
  use ConversionApi.DataCase

  alias ConversionApi.Directory

  describe "coins" do
    alias ConversionApi.Directory.Coins

    @valid_attrs %{name: "some name", rate: 42}
    @update_attrs %{name: "some updated name", rate: 43}
    @invalid_attrs %{name: nil, rate: nil}

    def coins_fixture(attrs \\ %{}) do
      {:ok, coins} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Directory.create_coins()

      coins
    end

    test "list_coins/0 returns all coins" do
      coins = coins_fixture()
      assert Directory.list_coins() == [coins]
    end

    test "get_coins!/1 returns the coins with given id" do
      coins = coins_fixture()
      assert Directory.get_coins!(coins.id) == coins
    end

    test "create_coins/1 with valid data creates a coins" do
      assert {:ok, %Coins{} = coins} = Directory.create_coins(@valid_attrs)
      assert coins.name == "some name"
      assert coins.rate == 42
    end

    test "create_coins/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_coins(@invalid_attrs)
    end

    test "update_coins/2 with valid data updates the coins" do
      coins = coins_fixture()
      assert {:ok, %Coins{} = coins} = Directory.update_coins(coins, @update_attrs)
      assert coins.name == "some updated name"
      assert coins.rate == 43
    end

    test "update_coins/2 with invalid data returns error changeset" do
      coins = coins_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_coins(coins, @invalid_attrs)
      assert coins == Directory.get_coins!(coins.id)
    end

    test "delete_coins/1 deletes the coins" do
      coins = coins_fixture()
      assert {:ok, %Coins{}} = Directory.delete_coins(coins)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_coins!(coins.id) end
    end

    test "change_coins/1 returns a coins changeset" do
      coins = coins_fixture()
      assert %Ecto.Changeset{} = Directory.change_coins(coins)
    end
  end
end
