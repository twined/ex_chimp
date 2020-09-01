defmodule ExChimp.List do
  @moduledoc """
  List-oriented API calls.
  """
  alias ExChimp.Client

  @type member_status :: :subscribed | :unsubscribed | :cleaned | :pending

  @spec all() :: {:ok, [map]}
  def all do
    query =
      %{}
      |> Map.put(:fields, "lists.id,lists.name,lists.stats.member_count")
      |> Map.put(:count, 100)
      |> Map.put(:offset, 0)
      |> URI.encode_query()

    case Client.get("lists?#{query}") do
      {:ok, %{body: %{"lists" => lists}}} -> {:ok, lists}
      {:ok, %{body: body}} -> {:error, body}
    end
  end

  @spec members(binary) :: {:ok, map} | {:error, binary}
  def members(list_id) do
    case Client.get("lists/#{list_id}/members") do
      {:ok, %{body: %{"status" => 404, "detail" => error}}} -> {:error, error}
      {:ok, %{body: body}} -> {:ok, body}
    end
  end

  @spec add_member(binary, member_status, binary, map, map) ::
          {:ok, map} | {:error, binary}
  def add_member(list_id, status, email, merge_fields, other_fields \\ %{}) do
    %{}
    |> Map.put(:email_address, email)
    |> Map.put(:status, status)
    |> Map.put(:merge_fields, merge_fields)
    |> Map.merge(other_fields)
    |> Jason.encode!()
    |> do_add_member(list_id)
  end

  @spec add_member(binary, member_status, binary) :: {:ok, map} | {:error, binary}
  def add_member(list_id, status, email) do
    %{}
    |> Map.put(:email_address, email)
    |> Map.put(:status, status)
    |> Jason.encode!()
    |> do_add_member(list_id)
  end

  defp do_add_member(data, list_id) do
    case Client.post("lists/#{list_id}/members", data) do
      {:ok, %{body: %{"status" => 400, "detail" => error}}} -> {:error, error}
      {:ok, %{body: body}} -> {:ok, body}
    end
  end
end
