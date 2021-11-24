defmodule ExChimp.List do
  @moduledoc """
  List-oriented API calls.
  """
  alias ExChimp.Client

  @type member_status :: :subscribed | :unsubscribed | :cleaned | :pending

  @spec all(binary) :: {:ok, [map]}
  def all(api_key) do
    query =
      %{}
      |> Map.put(:fields, "lists.id,lists.name,lists.stats.member_count")
      |> Map.put(:count, 100)
      |> Map.put(:offset, 0)
      |> URI.encode_query()

    case Client.api_get(api_key, "lists?#{query}") do
      {:ok, %{body: %{"lists" => lists}}} -> {:ok, lists}
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  @spec members(binary, binary) :: {:ok, map} | {:error, binary}
  def members(api_key, list_id) do
    case Client.api_get(api_key, "lists/#{list_id}/members") do
      {:ok, %{body: %{"status" => 404, "detail" => error}}} -> {:error, error}
      {:ok, %{body: body}} -> {:ok, body}
    end
  end

  @spec add_member(binary, binary, member_status, binary, map, map) ::
          {:ok, map} | {:error, binary}
  def add_member(api_key, list_id, status, email, merge_fields, other_fields \\ %{}) do
    %{}
    |> Map.put(:email_address, email)
    |> Map.put(:status, status)
    |> Map.put(:merge_fields, merge_fields)
    |> Map.merge(other_fields)
    |> do_add_member(list_id, api_key)
  end

  @spec add_member(binary, binary, member_status, binary) :: {:ok, map} | {:error, binary}
  def add_member(api_key, list_id, status, email) do
    %{}
    |> Map.put(:email_address, email)
    |> Map.put(:status, status)
    |> do_add_member(list_id, api_key)
  end

  @spec destroy_member(binary, binary, binary) :: {:ok, map} | {:error, binary}
  def destroy_member(api_key, list_id, email) do
    url = "lists/#{list_id}/members/#{md5_sum(email)}/actions/delete-permanent"

    case Client.api_post(api_key, url, "") do
      {:ok, %{body: %{"status" => 400, "detail" => error}}} -> {:error, error}
      {:ok, %{body: body}} -> {:ok, body}
    end
  end

  defp do_add_member(data, list_id, api_key) do
    url = "lists/#{list_id}/members/#{hash_email(data)}"

    case Client.api_put(api_key, url, Jason.encode!(data)) do
      {:ok, %{body: %{"status" => 400, "detail" => error}}} -> {:error, error}
      {:ok, %{body: body}} -> {:ok, body}
    end
  end

  defp hash_email(%{email_address: email}), do: md5_sum(email)

  defp md5_sum(binary),
    do:
      :crypto.hash(:md5, String.downcase(binary))
      |> Base.encode16(case: :lower)
end
