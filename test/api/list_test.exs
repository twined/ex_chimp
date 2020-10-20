defmodule ExChimp.ListTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start()
  end

  @fixtures_dir Path.join([__DIR__, "..", "fixtures"])
  @lists_success_json File.read!(Path.join(@fixtures_dir, "lists.json"))
  @list_members_success_json File.read!(Path.join(@fixtures_dir, "list_members.json"))
  @list_add_member_success_json File.read!(Path.join(@fixtures_dir, "list_member_add.json"))
  @lists_query_string "count=100&fields=lists.id%2Clists.name%2Clists.stats.member_count&offset=0"

  test "get lists success" do
    use_cassette :stub,
      url: "https://us12.api.mailchimp.com/3.0/lists?#{@lists_query_string}",
      method: "get",
      status_code: ["HTTP/1.1", 200, "OK"],
      body: @lists_success_json do
      {:ok, body} = ExChimp.List.all()
      assert body == Map.get(Jason.decode!(@lists_success_json), "lists")
    end
  end

  test "get list members" do
    use_cassette :stub,
      url: "https://us12.api.mailchimp.com/3.0/lists/asdf1234/members",
      method: "get",
      status_code: ["HTTP/1.1", 200, "OK"],
      body: @list_members_success_json do
      {:ok, body} = ExChimp.List.members("asdf1234")
      assert body == Jason.decode!(@list_members_success_json)
    end
  end

  test "add member to list" do
    use_cassette :stub,
      url: "https://us12.api.mailchimp.com/3.0/lists/asdf1234/members",
      method: "put",
      status_code: ["HTTP/1.1", 200, "OK"],
      body: @list_add_member_success_json do
      {:ok, body} =
        ExChimp.List.add_member("asdf1234", :subscribed, "urist.mcvankab+3@freddiesjokes.com")

      assert body == Jason.decode!(@list_add_member_success_json)
    end
  end
end
