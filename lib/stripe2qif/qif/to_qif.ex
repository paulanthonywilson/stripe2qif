defmodule Stripe2qif.Qif.ToQif do
  def to_qif(transactions) do
    ["!Type:Bank\n" | qif_entries(transactions)] |> Enum.join
  end

  defp qif_entries(transactions) do
    transactions
      |> Enum.map(&qif_transaction/1)
  end


  defp qif_transaction t do
    """
    D#{qif_date(t.date)}
    T#{qif_amount(t.amount)}
    P#{t.description}
    ^
    """
  end


  defp qif_date {year, month, day} do
    :io_lib.format("~2..0B/~2..0B/~4..0B",
     [day, month, year])
     |> List.flatten
     |> to_string
  end

  defp qif_amount amount do
    :io_lib.format("~.2f", [amount / 100]) |> to_string
  end
end
