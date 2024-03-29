defmodule Mix.Tasks.Exchimp.Lists do
  use Mix.Task

  def run(args) do
    api_key = List.first(args)
    Application.ensure_all_started(:httpoison)
    IO.puts("-------------------")
    IO.puts("id - name - members")
    IO.puts("-------------------")

    case ExChimp.List.all(api_key) do
      {:ok, lists} ->
        for %{"id" => id, "name" => name, "stats" => %{"member_count" => members}} <- lists do
          IO.puts("#{id} - #{name} - #{members}")
        end
    end

    IO.puts("\n")
  end
end
