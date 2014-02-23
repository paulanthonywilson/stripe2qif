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
end
