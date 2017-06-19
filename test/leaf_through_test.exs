defmodule LeafThroughTest do
  use ExUnit.Case
  import Test.Factory
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Test.Repo)

    users = for n <- 1..7, do: insert(:user)
    { :ok, users: users }
  end

  test "should return first page of users", %{users: users} do
    expected_users = Enum.sort_by(users, fn(u) -> u.username end) |> Enum.take(5)
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert expected_users == map.entries
  end

  test "should return the total count", %{users: users} do
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert Enum.count(users) == map.total_count
  end

  test "should return the current page" do
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert 1 == map.page
  end

  test "should return the total pages" do
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert 2 == map.pages
  end

  defp query do
    Test.User
    |> order_by([u], u.username)
  end
end
