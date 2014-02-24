defmodule DateConvertTest do
  use ExUnit.Case
  import Stripe2qif.DateConvert

  test "parse date" do
    assert parse_date("2012-03-14") == {2012, 3, 14}
    assert parse_date("2012-3-14") == {2012, 3, 14}
    assert parse_date("2012-03-4") == {2012, 3, 4}
  end
end
