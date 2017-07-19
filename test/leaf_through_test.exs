defmodule LeafThroughTest do
  use ExUnit.Case
  import Test.Factory
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Test.Repo)

    users = for _ <- 1..7, do: insert(:user)
    {:ok, users: users}
  end

  test "should return first page of users", %{users: users} do
    sorted_users = Enum.sort_by(users, fn(u) -> u.username end)
    expected_users = Enum.take(sorted_users, 5)
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert expected_users == map.entries
  end

  test "should return the total count", %{users: users} do
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert Enum.count(users) == map.total_count
  end

  test "should return the current page" do
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert map.page == 1
  end

  test "should return the total pages" do
    map = LeafThrough.paginate(Test.Repo, query(), 1)
    assert map.pages == 2
  end

  test "should return no entries with no results" do
    map = LeafThrough.paginate(Test.Repo, no_results_query(), 1)
    assert Enum.empty?(map.entries)
    assert map.total_count == 0
  end

  test "should not set the page information with no results" do
    map = LeafThrough.paginate(Test.Repo, no_results_query(), 1)
    assert map.page == 0
    assert map.pages == 0
  end

  defp query do
    order_by(Test.User, [u], u.username)
  end

  defp no_results_query do
    Test.User
    |> where([u], u.first_name == "12345")
    |> order_by([u], u.username)
  end
end
