defmodule ExChimp.ClientTest do
  use ExUnit.Case, async: true

  test "exposes the api functions" do
    functions = ExChimp.Client.__info__(:functions)
    assert {:api_get, 2} in functions
    assert {:api_put, 3} in functions
    assert {:api_post, 3} in functions
  end
end
