defmodule Stripe2qif do
  use Application.Behaviour
  import Stripe2qif.Stripe.Decode, only: [decode_balances: 1]
  import Stripe2qif.Stripe.TitoConvert, only: [tito_convert: 2]
  import Stripe2qif.Qif.ToQif, only: [to_qif: 1]
  import Stripe2qif.DateConvert, only: [date_to_unix_epoch: 1]

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Stripe2qif.Supervisor.start_link
  end


  def run api_key, tito, from \\ nil do
    Stripe2qif.Stripe.Api.fetch(api_key, "balance/history", params(from))
      |> decode_balances
      |> tito_convert(tito)
      |> to_qif
  end

  defp params from={_year,_month,_day} do
    [count: 100, "created[gte]": date_to_unix_epoch(from)]
  end

  defp params _ do
    [count: 100]
  end

end
