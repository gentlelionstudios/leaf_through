defmodule LeafThroughTest do
  use Test.RepoCase, async: true
  import Test.Factory
  import Ecto.Query
  import LeafThrough

  defp insert_users(_context) do
    users = for _ <- 1..7, do: insert(:user)
    {:ok, users: users}
  end

  defp query do
    order_by(Test.User, [u], u.username)
  end

  describe "with users in the database" do
    setup [:insert_users]

    test "returns the first page of users", %{users: users} do
      first_five_users = users
                         |> Enum.sort_by(fn(u) -> u.username end)
                         |> Enum.take(5)

      map = paginate(query(), 1)
      assert map.entries == first_five_users
    end

    test "returns the total count" do
      map = paginate( query(), 1)
      assert map.total_count == 7
    end

    test "returns the current page" do
      map = paginate(query(), 1)
      assert map.page == 1
    end

    test "returns the total pages" do
      map = paginate(query(), 1)
      assert map.pages == 2
    end
  end

  describe "with no users in the database" do
    test "return no entries" do
      map = paginate(query(), 1)
      assert Enum.empty?(map.entries)
    end

    test "returns 0 for the total count" do
      map = paginate(query(), 1)
      assert map.total_count == 0
    end

    test "returns 0 for the current page" do
      map = paginate(query(), 1)
      assert map.page == 0
    end

    test "returns 0 for the total pages" do
      map = paginate(query(), 1)
      assert map.pages == 0
    end
  end
end
