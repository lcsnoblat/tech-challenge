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
  
    def converter(amount, old_currency, target_currency) do
      to_usd = CurrencyConvert.converter(amount, old_currency, :USD)
      CurrencyConvert.converter(to_usd, :USD, target_currency)
    end
  
    def converter(amount, :USD, target_currency) do
      case check_currency(target_currency) do
        true ->
          rates = CurrencyConvert.read_currency_file("currency.txt")
          amount_in_decimal = Decimal.new(amount)
          {rate_from_file, _} = rates[target_currency]
          rate_in_decimal = Decimal.new(rate_from_file)
          converted_value = Decimal.mult(amount_in_decimal, rate_in_decimal)
            |> Decimal.round(2)
            |> Decimal.to_float
  
          {:ok, converted_value}
  
        false ->
          {:error, "Currency (#{target_currency}) not finded"}
      end
  
    end
  
    def converter(amount, old_currency, :USD) do
      case check_currency(old_currency) do
        true ->
          rates = CurrencyConvert.read_currency_file("currency.txt")
          amount_in_decimal = Decimal.new(amount)
          {rate_from_file, _} = rates[old_currency]
          rate_in_decimal = Decimal.new(rate_from_file)
          converted_value = Decimal.div(amount_in_decimal, rate_in_decimal)
            |> Decimal.round(2)
            |> Decimal.to_float
  
          {:ok, converted_value}
  
        false ->
          {:error, "Currency (#{old_currency}) not finded"}
      end
  
    end
  
  
  end