defmodule Stripe2qif.CLI do
  def main(argv) do
    run argv |> List.first
  end

  defp run nil do
    IO.puts "So, API key?"
  end


  defp run api_key do
    api_key
      |>  Stripe2qif.run
      |> Stripe2qif.Stripe2qif.TitoConvert
      |> IO.puts
  end
end
