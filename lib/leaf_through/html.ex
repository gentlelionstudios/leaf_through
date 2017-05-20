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
    Enum.reduce(1..map.pages, "", fn(p, acc) -> 
      acc <> if map.page == p, do: no_link(p), else: page_link(p)
    end)
  end
  defp no_link(page), do: "  <li>#{page}</li>\n" 
  defp page_link(page), do: "  <li><a href=\"?page=#{page}\">#{page}</a></li>\n"

  defp end_list, do: "</ol>\n"
end
