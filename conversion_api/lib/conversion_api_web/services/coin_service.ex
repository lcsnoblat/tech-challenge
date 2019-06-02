defmodule ConversionApiWeb.CoinService do
  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account

  def convert(base, currency, amount) do
    rates = get_rates_for_base_currency(base)
    IO.puts(rates)
  end


  def get_rates_for_base_currency(base) do
  	url = "https://api.exchangeratesapi.io/latest?base=" <> base

	case HTTPoison.get(url) do
	  {:ok, %{status_code: 200, body: body}} ->
	    Poison.decode!(body)

	  {:ok, %{status_code: 404}} ->
	    {error:, "Url inválida"}

	  {:error, %{reason: reason}} ->
	    {error:, "Ocorreu um erro ao processar o request: " <> reason}
	end
  end
end
