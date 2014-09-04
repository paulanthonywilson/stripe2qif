defmodule Stripe2qif.DateConvert do
  @unix_epoch_start 62167219200 # 1 Jan 1970

  def unix_epoch_to_date timestamp do
    case :calendar.gregorian_seconds_to_datetime(@unix_epoch_start + timestamp) do
      {date, _} -> date
    end
  end

  def date_to_unix_epoch date do
    :calendar.datetime_to_gregorian_seconds({date, {0,0,0}}) - @unix_epoch_start
  end

  def parse_date nil do nil end
  def parse_date date do
    case binary_date_to_list(date) do
      :error -> :error
      date_list -> date_list
                    |> Enum.map(&String.to_integer/1)
                    |> List.to_tuple
    end
  end

  defp binary_date_to_list date do
    case Regex.named_captures(~r/(?<year>\d{4})-(?<month>\d{1,2})-(?<day>\d{1,2})/, date) do
      [year: year, month: month, day: day] -> [year, month, day]
      _                                    -> :error
    end
  end

end
