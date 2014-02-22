defmodule Stripe2qif.Stripe.Api do
  alias HTTPotion.Response
  @user_agent  [ "User-agent": "Elixir:"]


  def fetch(api_key, command, params) do
    url = "https://api.stripe.com/v1/#{command}?#{param_string(params)}"
    case HTTPotion.get(url, @user_agent, http_options(api_key)) do
      Response[body: body, status_code: status, headers: _headers ] when status in 200..299 -> body
      Response[body: body, status_code: status, headers: _headers ] -> raise "Stripe returned status code '#{status}' with body:\n#{body}"
    end
  end

  defp http_options(api_key) do
    basic_auth = {api_key |> String.to_char_list!, ''}
    [ibrowse: [basic_auth: basic_auth]]
  end


  defp param_string(params) do
    (params
      |> Enum.map(fn {key, val} -> "#{key}=#{val}" end))
      |> Enum.join("&")
  end
end

