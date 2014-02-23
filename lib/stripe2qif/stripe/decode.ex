defmodule Stripe2qif.Stripe.Decode do
  alias Stripe2qif.Stripe.BalanceTransaction
  import Stripe2qif.DateConvert, only: [unix_epoch_to_date: 1]

  def decode_balances << json :: binary >> do
    json
      |> Jsonex.decode
      |> decode_balances
  end

  def decode_balances balances do []
  balances["data"]
    |> Enum.map(&data_transaction_to_record/1)
    |> List.flatten
  end


  defp data_transaction_to_record t do
    if 0 == t["fee"] do
      main_transaction(t)
    else
      [main_transaction(t), fee_transaction(t)]
    end
  end

  defp main_transaction t do
    BalanceTransaction[
      description: t["description"],
      currency: t["currency"],
      amount: t["amount"],
      date: t["created"] |> unix_epoch_to_date,
      ]
  end

  defp fee_transaction t do
    BalanceTransaction[
      description: "(fee) #{t["description"]}",
      currency: t["currency"],
      amount: -t["fee"],
      date: t["created"] |> unix_epoch_to_date,
      ]
  end

end
