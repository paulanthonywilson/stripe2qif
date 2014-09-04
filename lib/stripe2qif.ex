defmodule Stripe2qif do
  use Application
  import Stripe2qif.Stripe.Decode, only: [decode_balances: 1]
  import Stripe2qif.Stripe.TitoConvert, only: [tito_convert: 2]
  import Stripe2qif.Qif.ToQif, only: [to_qif: 1]
  import Stripe2qif.DateConvert, only: [date_to_unix_epoch: 1]

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Stripe2qif.Supervisor.start_link
  end


  def run api_key, tito, until \\ nil do
    Stripe2qif.Stripe.Api.fetch(api_key, "balance/history", params(until))
      |> decode_balances
      |> tito_convert(tito)
      |> to_qif
  end

  defp params until={_year,_month,_day} do
    [count: 100, "created[lte]": date_to_unix_epoch(until)]
  end

  defp params _ do
    [count: 100]
  end

end
