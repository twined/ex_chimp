defmodule ExChimp.ListTest do
  use ExUnit.Case, async: true

  alias ExChimp.List

  @fixtures_dir Path.join([__DIR__, "..", "fixtures"])
  @lists_success_json File.read!(Path.join(@fixtures_dir, "lists.json"))
  @list_members_success_json File.read!(Path.join(@fixtures_dir, "list_members.json"))
  @list_add_member_success_json File.read!(Path.join(@fixtures_dir, "list_member_add.json"))
  @test_email "urist.mcvankab+3@freddiesjokes.com"

  setup do
    Application.put_env(:ex_chimp, :req_options, plug: {Req.Test, ExChimp})
    on_exit(fn -> Application.delete_env(:ex_chimp, :req_options) end)
    :ok
  end

  defp stub(status, json) do
    Req.Test.stub(ExChimp, fn conn ->
      conn
      |> Plug.Conn.put_resp_content_type("application/json")
      |> Plug.Conn.send_resp(status, json)
    end)
  end

  test "get lists success" do
    stub(200, @lists_success_json)

    {:ok, body} = List.all("yourapikey-us12")
    assert body == Map.get(Jason.decode!(@lists_success_json), "lists")
  end

  test "get list members" do
    stub(200, @list_members_success_json)

    {:ok, body} = List.members("yourapikey-us12", "asdf1234")
    assert body == Jason.decode!(@list_members_success_json)
  end

  test "add member to list" do
    stub(200, @list_add_member_success_json)

    {:ok, body} = List.add_member("yourapikey-us12", "asdf1234", :subscribed, @test_email)
    assert body == Jason.decode!(@list_add_member_success_json)
  end
end
