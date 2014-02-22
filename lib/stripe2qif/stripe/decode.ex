defrecord Stripe.BalanceTransaction, date: nil, amount: nil, description: nil, currency: nil

defmodule Stripe.Decode do

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
    Stripe.BalanceTransaction[
      description: t["description"],
      currency: t["currency"],
      amount: t["amount"],
      date: t["created"] |> unix_epoch_to_date,
      ]
  end

  defp fee_transaction t do
    Stripe.BalanceTransaction[
      description: t["description"],
      currency: t["currency"],
      amount: -t["fee"],
      date: t["created"] |> unix_epoch_to_date,
      ]
  end

  @unix_epoch_start 62167219200 # 1 Jan 1970
  defp unix_epoch_to_date timestamp do
    case :calendar.gregorian_seconds_to_datetime(@unix_epoch_start + timestamp) do
      {date, _} -> date
    end
  end

end
