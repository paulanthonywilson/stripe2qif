defmodule Stripe.ApiTest do
  use ExUnit.Case, async: false
  alias HTTPotion.Response
  import Stripe2qif.Stripe.Api, only: [fetch: 3]

  setup do
    :meck.new(HTTPotion)
    :ok
  end


  defp stub_httpotion_get(f) do
    :meck.expect(HTTPotion, :get, f)
  end


  test "successful request returns ok with the body" do
    stub_httpotion_get fn _,_,_ ->
      %Response{status_code: 200, body: "everything is fine"}
    end

    assert fetch("123", "hi", []) == "everything is fine"
    :meck.unload(HTTPotion)
  end

  test "unsuccessful request raises an exception" do
    stub_httpotion_get fn _,_, _ -> %Response{status_code: 500, body: "everything is terrible"} end
    assert_raise RuntimeError, "Stripe returned status code '500' with body:\neverything is terrible", fn ->
      assert fetch("123", "hi", []) == {:error, "everything is terrible"}
    end
    :meck.unload(HTTPotion)
  end


  test "the stripe api is called with the specific command" do
    stub_httpotion_get fn url, _, _ ->
      assert url == "https://api.stripe.com/v1/abc/def?"
      %Response{status_code: 200}
    end

    fetch "123", "abc/def", []
    :meck.unload(HTTPotion)
  end

  test "parameters" do
    stub_httpotion_get fn url, _, _ ->
      assert url == "https://api.stripe.com/v1/abc/def?param1=hello&param2=world"
      %Response{status_code: 200}
    end

    fetch "123", "abc/def", [param1: "hello", param2: "world"]
    :meck.unload(HTTPotion)
  end

  test "basic authentication is used" do
    stub_httpotion_get fn _, _, options ->
      assert options == [ibrowse: [basic_auth: {'123', []}]]
      %Response{status_code: 200}
    end

    fetch "123", "abc/def", []
    :meck.unload(HTTPotion)
  end

end

