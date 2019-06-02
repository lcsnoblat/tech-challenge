defmodule ConversionApiWeb.CoinService do
  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account

  def convert(base, currency, amount) do
    with {:ok, rates} = response <- get_rates_for_base_currency(base, currency), 
         {:ok, returned_value} = converted_value <- convert_currency(rates, amount, currency) do
      {:ok, returned_value}
    end
  end

  def get_rates_for_base_currency(base, currency) do
  	url = "https://api.exchangeratesapi.io/latest?base=" <> base <> "&symbols=" <> currency

  	case HTTPoison.get(url) do
  	  {:ok, %{status_code: 200, body: body}} ->
        {:ok, Poison.decode!(body)}
        |> IO.inspect()

  	  {:ok, %{status_code: 404}} ->
        {:error, "Moeda informada não existe!"}

  	  {:error, %{reason: reason}} -> 
  	    {:error, "Ocorreu um erro ao processar o request: " <> reason}
  	end
  end

  def convert_currency(%{"rates" => rates},_,_) when is_nil(rates), do: {:error, "Error ao receber valores de conversão da API"}

  def convert_currency(rates, amount, currency) do
    {:ok, amount * rates["rates"][currency]}
  end
end
