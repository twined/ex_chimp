defmodule ExChimp.ClientTest do
  use ExUnit.Case, async: true

  test "use" do
    assert {:get, 1} in ExChimp.Client.__info__(:functions)
  end
end
