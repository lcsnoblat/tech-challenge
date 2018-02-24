defmodule CurrencyConvert do
@moduledoc """
  Documentation for CurrencyConvert.
  """
  @doc """
  
  """
  @spec read_currency_file(String.t()) :: [key: float]
  def read_currency_file(currency_file_name) do
    currency_file_name
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(fn x ->
      [currency, val] = String.split(x, ":")

      currency_key =
        currency
        |> String.trim("\"")
        |> String.to_atom()

      {currency_key, Float.parse(val)}
    end)
  end

  def check_currency(currency_to_check) do
    CurrencyConvert.read_currency_file("currency.txt")
    |> Keyword.keys()
    |> Enum.any?(fn currency -> currency == currency_to_check end)
  end
end