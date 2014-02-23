defmodule Stripe2qif.Stripe.TitoConvert do
  alias Stripe2qif.Stripe.BalanceTransaction
  def tito_convert balance_transactions, true do
    balance_transactions |> Enum.map(&convert_transaction/1)
  end

  def tito_convert balance_transactions, _ do
    balance_transactions
  end

  defp convert_transaction transaction  = BalanceTransaction[description: description] do
    if captures =  Regex.named_captures(%r/^(?<description>.*)\s+ticket/g, description) do
      transaction.update(description: captures[:description])
    else
      transaction
    end
  end



end
