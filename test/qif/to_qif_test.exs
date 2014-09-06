defmodule Qif.ToQifTest do
  use ExUnit.Case
  alias Stripe2qif.Stripe.BalanceTransaction
  import Stripe2qif.Qif.ToQif

  test "creates a bank qif" do
    assert to_qif([]) == "!Type:Bank\n"
  end

  test "creates qifs" do
    assert to_qif(
      [
        %BalanceTransaction{date: {2014, 2, 10}, amount: -2350, description: "loss", currency: "gbp"},
        %BalanceTransaction{date: {2014, 2, 11}, amount: 2250, description: "theft", currency: "gbp"},
        ]) ==
      """
      !Type:Bank
      D10/02/2014
      T-23.50
      Ploss
      ^
      D11/02/2014
      T22.50
      Ptheft
      ^
      """

  end
end
