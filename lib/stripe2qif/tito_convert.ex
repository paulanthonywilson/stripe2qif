defmodule Stripe2qif.Stripe.TitoConvert do
  alias Stripe2qif.Stripe.BalanceTransaction
  def convert {:tito, b = BalanceTransaction[description: description]} do
    if captures =  Regex.named_captures(%r/^(?<description>.*)\s+tickets/g, description) do
      b.update(description: captures[:description])
    else
      b
    end
  end


  def convert({_, b}) do
    b
  end
end
