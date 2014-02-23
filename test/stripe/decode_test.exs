defmodule Stripe.DecodeTest do
  use ExUnit.Case
  import Stripe2qif.Stripe.Decode


  defp balance_json do
    File.read!("#{__DIR__}/balance_fixture.json")
  end

  test "decodes transactions" do
    t = decode_balances(balance_json) |> List.first
    assert t.description == "STRIPE TRANSFER"
    assert t.currency == "gbp"
    assert t.amount == -10000
    assert t.date == {2014, 2, 19}
  end

  test "adds fees as separate transaction" do
    b = decode_balances(balance_json)
    assert b |> length == 3
    assert (b |> Enum.map(&(&1.amount))) == [-10000, 80000, -1940]
  end

end

