defmodule LeafThrough.HtmlTest do
  use ExUnit.Case, async: true
  alias LeafThrough.Html

  test "generates paging links for zero entries" do
    map = map_with_no_entries()

    assert Html.leaf_through(map) == """
    <ol class="paging">
      <li>1</li>
    </ol>
    """
  end

  test "generates paging links for multiple pages" do
    map = map_with_entries(18, 2)

    assert Html.leaf_through(map) == """
    <ol class="paging">
      <li><a href="?page=1">1</a></li>
      <li>2</li>
      <li><a href="?page=3">3</a></li>
      <li><a href="?page=4">4</a></li>
    </ol>
    """
  end

  defp map_with_no_entries do
    %{total_entries: 0, page: 1, pages: 1}
  end

  def map_with_entries(total, current_page) do
    %{total_entries: total, 
      page: current_page, 
      pages: LeafThrough.Calculate.pages(total)}
  end
end
