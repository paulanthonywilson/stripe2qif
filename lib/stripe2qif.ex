defmodule Stripe2qif do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Stripe2qif.Supervisor.start_link
  end


  def run api_key do
    Stripe2qif.Stripe.Api.fetch(api_key, "balance/history", [count: 100])
      |> Stripe2qif.Stripe.Decode.decode_balances
      |> Stripe2qif.Qif.ToQif.to_qif
  end
end
