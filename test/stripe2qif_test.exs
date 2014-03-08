defmodule Stripe2qifTest do
  use ExUnit.Case
  alias Stripe2qif.Stripe.Api

  import Stripe2qif, only: [run: 3]

  @empty_dataset [{"data", []}]

  setup do
    :meck.new(Api)
    :ok
  end

  teardown do
    :meck.unload(Api)
    :ok
  end


  test "when until is nil, there is no date filter" do
    :meck.expect(Api, :fetch, fn _api, _command, params ->
      assert params == [count: 100]
      @empty_dataset
    end)

    run "123", true, nil
  end

  @feb_23_2014_as_unix_epoch 1393113600
  test "when until is populated, there is a date filter" do
    :meck.expect(Api, :fetch, fn _api, _command, params ->
      assert params == [count: 100, "created[lte]": 1393113600]
      @empty_dataset
    end)

    run "123", true, {2014, 02, 23}
  end
end
