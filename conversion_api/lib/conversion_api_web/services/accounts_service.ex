defmodule ConversionApiWeb.AccountService do
	alias ConversionApi.Transfer
    alias ConversionApi.Transfer.Account

	def transfer(from_account, to_account, value) do
		account_origin = Transfer.get_account!(from_account)
        account_destiny = Transfer.get_account!(to_account)

        case Integer.parse(value) do
        	{x, ""} ->
        		origin_account_balance = subtract_balance(account_origin, x)
        		destiny_account_balance = add_balance(account_destiny, x)

				updated_origin_account = Transfer.update_account(account_origin, origin_account_balance)
        		updated_origin_destiny = Transfer.update_account(account_destiny, destiny_account_balance)
        		updated_origin_account
		    :false ->
		    	{:error, "Valor inválido"}
		end
	end

	def subtract_balance(%Account{} = account_origin, value) do
		case account_origin.balance > value do
         	:true ->
         		%{balance: account_origin.balance - value}
         	:false ->
         		{:error, "Você não possui saldo o suficiente!"}
        end 
	end

	def add_balance(%Account{} = account_destiny, value) do
		%{balance: account_destiny.balance + value}
	end
end
