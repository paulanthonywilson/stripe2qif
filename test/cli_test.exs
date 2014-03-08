defmodule CliTest do
  use ExUnit.Case

  import Stripe2qif.CLI, only: [parse_args: 1]

  test "parse args returns :help if selected or unfathamable" do
    assert parse_args(["--help"]) == :help
    assert parse_args(["--help", "yada"]) == :help
    assert parse_args(["-h"]) == :help
    assert parse_args(["--help", "--tito", "yada"]) == :help
    assert parse_args([]) == :help
  end

  test "parse args with just api key" do
    assert parse_args(["12345"]) == {"12345", false, nil}
  end

  test "parse args with tito option" do
    assert parse_args(["--tito", "12345"]) == {"12345", true, nil}
  end

  test "parse args with until date" do
    assert parse_args(["--until", "2014-01-15", "12345"]) == {"12345", false, {2014, 1, 15}}
  end

  test "parse args with until date and tito" do
    assert parse_args(["--until","2014-01-15", "--tito", "12345"]) == {"12345", true, {2014, 1, 15}}
    assert parse_args(["--tito", "--until","2014-01-15", "12345"]) == {"12345", true, {2014, 1, 15}}
  end

  test "parse args with invalid date" do
    assert parse_args(["--until", "tuesday", "12345"]) == :help
  end
end
