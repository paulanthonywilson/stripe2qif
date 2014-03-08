defmodule Stripe2qif.CLI do
  import Stripe2qif.DateConvert, only: [parse_date: 1]
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
      --until DATE            Display transactions up to, and including, this date. yyyy-mm-dd
      --tito                  Truncate descriptions before the word "ticket" to make FreeAgent explanations easier
    """
    System.halt(0)
  end

  defp run {api_key, tito, until} do
    Stripe2qif.run(api_key, tito, until)
      |> IO.puts
  end

  @doc """
  `argv` can be -h or --help, which returns   `:help`.

  Otherwise it is the Stripe api key, optional tito flag, and optional --until date in yyyy-mm-dd

  Return either
    :help
    {api_key, tito_flag (true or false), until (may be nil)}
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
    case {!!options[:help], !!options[:tito], parse_date(options[:until])} do
      {true, _, _} -> :help
      {_, _, :error} -> :help
      {_, tito, date} -> {api_key, tito, date}
    end
  end


end
