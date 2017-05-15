defmodule LeafThrough do
  import Ecto.Query, only: [limit: 2, offset: 2, exclude: 2, select: 2]
  import LeafThrough.Calculate

  defmacro __using__(_opt) do
    quote do
      @doc """
      LeafThrough is designed to be used by a repo module.
      """
      @spec paginate(Ecto.Queryable.t, integer) :: map
      def paginate(query, page_number) do
        LeafThrough.paginate(__MODULE__, query, page_number)
      end
    end
  end

  def paginate(repo, query, page_number) do
    %{
      data:  get_data(repo, query, page_number), 
      page:  page_number, 
      total: calculate_total(repo, query) || 0
    }
  end

  defp get_data(repo, query, page_number) do
    query
    |> set_limit()
    |> set_start(page_number)
    |> retrieve(repo)
  end

  defp calculate_total(repo, query) do
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
