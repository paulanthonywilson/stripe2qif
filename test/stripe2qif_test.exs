defmodule Stripe2qifTest do
  use ExUnit.Case
  alias Stripe2qif.Stripe.Api

  import Stripe2qif, only: [run: 3]

  def empty_dataset do
    :jiffy.decode("{\"data\": []}", [:return_maps])
  end

  setup do
    :meck.new(Api)
    :ok
  end


  test "when until is nil, there is no date filter" do
    try do
    :meck.expect(Api, :fetch, fn _api, _command, params ->
      assert params == [count: 100]
      empty_dataset
    end)

    run "123", true, nil
    after
    :meck.unload(Api)
    end
  end

  @feb_23_2014_as_unix_epoch 1393113600
  test "when until is populated, there is a date filter" do
    try do
    :meck.expect(Api, :fetch, fn _api, _command, params ->
      assert params == [count: 100, "created[lte]": 1393113600]
      empty_dataset
    end)

    run "123", true, {2014, 02, 23}
    after
    :meck.unload(Api)
    end
  end
end
