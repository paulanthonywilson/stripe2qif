defmodule Stripe.TitoConvert do
  use ExUnit.Case
  alias Stripe2qif.Stripe.BalanceTransaction
  import Stripe2qif.Stripe.TitoConvert

  test "doesn't convert not matching tickets" do
    assert convert({:tito, BalanceTransaction[description: "Hello matey"]}).description == "Hello matey"
  end

  test "converts up to the word ticket" do
    assert convert({:tito, BalanceTransaction[description: "Super matey tickets"]}).description == "Super matey"
  end


  test "converts nothing without tito" do
    assert convert({:not, BalanceTransaction[description: "Super matey tickets"]}).description == "Super matey tickets"
  end


end
