defmodule LeafThrough.Html do
  @moduledoc """
  Provides functions that generate HTML pagination links.
  """

  @doc """
  Generate the paging links given the pagination map.
  """
  def leaf_through(map) do
    start_list() <> page_links(map) <> end_list()
  end

  defp start_list, do: "<ol class=\"paging\">\n"

  defp page_links(map) do
    Enum.reduce(map.pages..1, "", fn(n, acc) -> 
      if map.page == n do
        "  <li>#{n}</li>\n" <> acc 
      else
        "  <li><a href=\"?page=#{n}\">#{n}</a></li>\n" <> acc 
      end
    end)
  end

  defp end_list, do: "</ol>\n"
end
