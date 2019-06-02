defmodule ConversionApi.Directory do
  @moduledoc """
  The Directory context.
  """

  import Ecto.Query, warn: false
  alias ConversionApi.Repo

  alias ConversionApi.Directory.Coins

  @doc """
  Returns the list of coins.

  ## Examples

      iex> list_coins()
      [%Coins{}, ...]

  """
  def list_coins do
    Repo.all(Coins)
  end

  @doc """
  Gets a single coins.

  Raises `Ecto.NoResultsError` if the Coins does not exist.

  ## Examples

      iex> get_coins!(123)
      %Coins{}

      iex> get_coins!(456)
      ** (Ecto.NoResultsError)

  """
  def get_coins!(id), do: Repo.get!(Coins, id)

  @doc """
  Creates a coins.

  ## Examples

      iex> create_coins(%{field: value})
      {:ok, %Coins{}}

      iex> create_coins(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_coins(attrs \\ %{}) do
    %Coins{}
    |> Coins.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a coins.

  ## Examples

      iex> update_coins(coins, %{field: new_value})
      {:ok, %Coins{}}

      iex> update_coins(coins, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_coins(%Coins{} = coins, attrs) do
    coins
    |> Coins.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Coins.

  ## Examples

      iex> delete_coins(coins)
      {:ok, %Coins{}}

      iex> delete_coins(coins)
      {:error, %Ecto.Changeset{}}

  """
  def delete_coins(%Coins{} = coins) do
    Repo.delete(coins)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking coins changes.

  ## Examples

      iex> change_coins(coins)
      %Ecto.Changeset{source: %Coins{}}

  """
  def change_coins(%Coins{} = coins) do
    Coins.changeset(coins, %{})
  end
end
