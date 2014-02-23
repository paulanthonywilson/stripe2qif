defmodule Stripe2qif.CLI do
  def main(argv) do
    argv
      |> parse_args
      |> run
  end

  defp run :help do
    IO.puts """
    usage:  stripe2qf [OPTIONS] <apikey>
      Output qif for up to 100 stripe transactions.

      --help, -h              Display this message
      --from DATE             Display transactions from the date
      --tito                  Truncate descriptions before the word "ticket" to make FreeAgent explanations easier
    """
    System.halt(0)
  end

  defp run {api_key, tito, from} do
    Stripe2qif.run(api_key, tito, from)
      |> IO.puts
  end

  @doc """
  `argv` can be -h or --help, which returns   `:help`.

  Otherwise it is the Stripe api key, optional tito flag, and optional --from date in yyyy-mm-dd

  Return either
    :help
    {api_key, tito_flag (true or false), from (may be nil)}
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean, tito: :boolean],
                                     aliases:  [ h:    :help   ])
    case parse do
      {[help: true], _, _} -> :help
      {options, [api_key | _], _} -> parse_options options, api_key
      _ -> :help
    end
  end

  defp parse_options options, api_key do
    case {!!options[:help], !!options[:tito], parse_date(options[:from])} do
      {true, _, _} -> :help
      {_, _, :error} -> :help
      {_, tito, date} -> {api_key, tito, date}
    end
  end

  defp parse_date nil do nil end
  defp parse_date date do
    case binary_date_to_list(date) do
      :error -> :error
      date_list -> date_list
                    |> Enum.map(&binary_to_integer/1)
                    |> list_to_tuple
    end
  end

  defp binary_date_to_list date do
    case Regex.named_captures(%r/(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/g, date) do
      [year: year, month: month, day: day] -> [year, month, day]
      _                                    -> :error
    end
  end

end
