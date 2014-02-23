defmodule Stripe2qif do
  use Application.Behaviour
  import Stripe2qif.Stripe.Decode, only: [decode_balances: 1]
  import Stripe2qif.Stripe.TitoConvert, only: [tito_convert: 2]
  import Stripe2qif.Qif.ToQif, only: [to_qif: 1]

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Stripe2qif.Supervisor.start_link
  end


  def run api_key do
    Stripe2qif.Stripe.Api.fetch(api_key, "balance/history", [count: 100])
      |> decode_balances
      |> tito_convert true
      |> to_qif
  end
end
