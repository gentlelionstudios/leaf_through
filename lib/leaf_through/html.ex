defmodule LeafThrough.Html do
  def leaf_through(map) do
    start_list() <> page_links(map) <> end_list()
  end

  defp start_list, do: "<ol class=\"paging\">\n"

  defp page_links(map) do
    Enum.reduce(map.leaves..1, "", fn(n, acc) -> 
      if map.folio == n do
        "  <li>#{n}</li>\n" <> acc 
      else
        "  <li><a href=\"?page=#{n}\">#{n}</a></li>\n" <> acc 
      end
    end)
  end

  defp end_list, do: "</ol>\n"
end
