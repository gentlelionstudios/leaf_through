defmodule LeafThrough do
  @moduledoc """
  Provides Ecto pagination functions.
  """

  import Ecto.Query, only: [limit: 2, offset: 2, exclude: 2, select: 2]
  import LeafThrough.Calculate

  defmacro __using__(_options) do
    quote do
      @doc """
      Paginates an Ecto query and returns a `Map` of the results for the given page number.

      The map consists of the following metadata:

        * entries:     query results for the given page

        * total_count: count of query results for all pages

        * page:        requested page

        * pages:       total pages

      ## Example map

      %{ entries: [...], total_count: 14, page: 2, pages: 3 }
      """
      @spec paginate(query :: Ecto.Query.t, integer) :: map
      def paginate(query, page) do
        LeafThrough.paginate(__MODULE__, query, page)
      end
    end
  end

  def paginate(repo, query, page_number) do
    limit_to_page(query, page_number)
    |> execute(repo)
    |> calculate_total(query, repo)
    |> add_pages(page_number)
  end

  defp limit_to_page(query, page_number) do
    query
    |> set_limit()
    |> set_start(page_number)
  end

  defp execute(query, repo) do
    %{entries: repo.all(query)}
  end

  defp calculate_total(map, query, repo) do
    total = query
            |> reset_query()
            |> count(repo)
    Map.put(map, :total_count, total)
  end

  defp add_pages(map, page_number) do
    map
    |> Map.put(:page, page_number)
    |> Map.put(:pages, pages(map.total_count))
  end

  defp set_limit(query) do
    limit(query, ^per_page())
  end

  defp set_start(query, page_number) do
    offset(query, ^starting_row(page_number))
  end

  defp reset_query(query) do
    query
    |> exclude(:select)
    |> exclude(:preload)
    |> exclude(:order_by)
  end

  defp count(query, repo) do
    query
    |> select(count("*"))
    |> repo.one()
  end
end
