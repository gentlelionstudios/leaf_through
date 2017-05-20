defmodule LeafThrough do
  import Ecto.Query, only: [limit: 2, offset: 2, exclude: 2, select: 2]
  import LeafThrough.Calculate

  defmacro __using__(_options) do
    quote do
      @doc """
      Paginates an Ecto query and returns a `Map` of the results for the given page number.

      The map consists of the following metadata:

        * entries:       query results for the given page

        * total_entries: count of query results for all pages

        * page:          requested page

        * pages:         total pages

      ## Example map
      
      %{ entries: [...], total_entries: 14, page: 2, pages: 3 }
      """
      @spec paginate(query :: Ecto.Query.t, integer) :: map
      def paginate(query, page) do
        LeafThrough.paginate(__MODULE__, query, page)
      end
    end
  end

  def paginate(repo, query, page_number) do
    entries       = entries(repo, query, page_number)
    total_entries = total_entries(repo, query) || 0
    pages         = pages(total_entries)
    %{
      entries:       entries, 
      total_entries: total_entries,
      page:          page_number, 
      pages:         pages
    }
  end

  defp entries(repo, query, page_number) do
    query
    |> set_limit()
    |> set_start(page_number)
    |> retrieve(repo)
  end

  defp total_entries(repo, query) do
    query
    |> reset_query()
    |> count(repo)
  end

  defp set_limit(query) do
    limit(query, ^per_page())
  end

  defp set_start(query, page_number) do
    offset(query, ^starting_row(page_number))
  end

  defp retrieve(query, repo) do
    repo.all(query)
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
