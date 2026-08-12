defmodule ExChimp.Client do
  @moduledoc """
  API client.
  """

  def encode_api_key(api_key) do
    Base.encode64(":#{api_key}")
  end

  def api_get(api_key, url) do
    api_key |> request(url) |> Req.get()
  end

  def api_put(api_key, url, data) do
    api_key |> request(url) |> Req.put(body: data)
  end

  def api_post(api_key, url, data) do
    api_key |> request(url) |> Req.post(body: data)
  end

  defp request(api_key, url) do
    [
      url: get_url(api_key, url),
      headers: [
        {"authorization", "Basic #{encode_api_key(api_key)}"},
        {"content-type", "application/json"}
      ]
    ]
    |> Keyword.merge(Application.get_env(:ex_chimp, :req_options, []))
    |> Req.new()
  end

  defp get_url(api_key, url) do
    shard = extract_shard(api_key)
    "https://#{shard}.api.mailchimp.com/3.0/#{url}"
  end

  defp extract_shard(api_key) do
    case String.split(api_key, "-") do
      [_, shard_key] -> shard_key
      _ -> raise "Could not extract shard from API-key. Please check your API key."
    end
  end
end
