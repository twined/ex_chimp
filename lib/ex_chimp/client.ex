defmodule ExChimp.Client do
  @moduledoc """
  API client.
  """
  use HTTPoison.Base

  def process_url(url) do
    base_url() <> url
  end

  def process_response_body(""),
    do: nil

  def process_response_body(body) do
    Poison.decode!(body)
  end

  defp process_request_headers(headers) do
    base_api_key = Base.encode64(":#{api_key()}")
    Enum.into(headers, [
      {"Authorization", "Basic #{base_api_key}"},
      {"Content-type", "application/json"}
    ])
  end

  defp base_url do
    shard = extract_shard()
    "https://#{shard}.api.mailchimp.com/3.0/"
  end

  defp api_key do
    ExChimp.config(:api_key)
  end

  defp extract_shard do
    case String.split(api_key(), "-") do
      [_, shard_key] -> shard_key
      _ -> raise "Could not extract shard from API-key. Please check your API key."
    end
  end
end
