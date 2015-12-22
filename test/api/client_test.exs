defmodule ExChimp.ClientTest do
  use ExUnit.Case, async: true

  test "use" do
    assert {:get, 1} in ExChimp.Client.__info__(:functions)
  end

  test "process_url" do
    assert ExChimp.Client.process_url("test/url")
           == "https://us12.api.mailchimp.com/3.0/test/url"
  end
end