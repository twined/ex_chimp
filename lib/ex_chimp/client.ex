defmodule ExChimp.Client do
  @moduledoc """
  API client.
  """
  use HTTPoison.Base

  def process_response_body(""), do: nil
  def process_response_body(body), do: Jason.decode!(body)

  def process_request_headers(headers) do
    (headers ++
       [
         {"Content-type", "application/json"}
       ])
    |> Enum.uniq_by(fn {key, _} -> key end)
  end

  def encode_api_key(api_key) do
    Base.encode64(":#{api_key}")
  end

  def api_get(api_key, url) do
    base_api_key = encode_api_key(api_key)
    api_key_header = [{"Authorization", "Basic #{base_api_key}"}]
    get(get_url(api_key, url), api_key_header)
  end

  def api_put(api_key, url, data) do
    base_api_key = encode_api_key(api_key)
    api_key_header = [{"Authorization", "Basic #{base_api_key}"}]
    put(get_url(api_key, url), data, api_key_header)
  end

  def api_post(api_key, url, data) do
    base_api_key = encode_api_key(api_key)
    api_key_header = [{"Authorization", "Basic #{base_api_key}"}]
    post(get_url(api_key, url), data, api_key_header)
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
