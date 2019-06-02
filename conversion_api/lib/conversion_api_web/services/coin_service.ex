defmodule ConversionApiWeb.CoinService do
  alias ConversionApi.Transfer
  alias ConversionApi.Transfer.Account

  def transfer(oque_eu_quero) do
    with %Account{} = account_origin <- Transfer.get_account!(oque_eu_quero["id_from"]),
         %Account{} = account_destiny <- Transfer.get_account!(oque_eu_quero["id_to"]) do
      account_origin.balance - 10
      Transfer.update(account_origin)
    end
  end
end
