defmodule Stripe.TitoConvert do
  use ExUnit.Case
  alias Stripe2qif.Stripe.BalanceTransaction
  import Stripe2qif.Stripe.TitoConvert#, only: [tito_convert: 2]


  defp convert_description description, do_conversion do
    (tito_convert([BalanceTransaction[description: description]], do_conversion) |> List.first).description
  end

  test "doesn't convert not matching tickets" do
    assert convert_description("Hello matey", true) == "Hello matey"
  end

  test "converts up to the word ticket" do
    assert convert_description("Super matey ticket yada yada", true) == "Super matey"
  end


  test "converts nothing when convert flag is false" do
    assert convert_description("Super matey ticket yada yada", false) == "Super matey ticket yada yada"
  end


end
