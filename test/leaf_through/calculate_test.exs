defmodule LeafThrough.CalculateTest do
  use ExUnit.Case, async: false
  alias LeafThrough.Calculate

  test "gets per_page value from config" do
    assert Calculate.per_page() == 5
  end

  test "return per_page default when the config is missing" do
    Application.delete_env(:leaf_through, :per_page)
    assert Calculate.per_page() == 10
    Application.put_env(:leaf_through, :per_page, 5)
  end

  test "calculate the starting row" do
    assert Calculate.starting_row(1) == 0
    assert Calculate.starting_row(2) == 5
    assert Calculate.starting_row(3) == 10
  end
end
