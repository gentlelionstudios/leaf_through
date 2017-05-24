defmodule LeafThrough.Calculate do
  @moduledoc """
  Provides calculation functions.
  """

  @default_per_page 10

  @doc """
  Returns the per_page configuration value, otherwise returns the default
  value `#{@default_per_page}`.
  """
  def per_page do
    Application.get_env(:leaf_through, :per_page, @default_per_page)
  end

  @doc """
  Determines the starting offset given the current page.
  """
  def starting_row(page) do
    (page - 1) * per_page()
  end

  @doc """
  Calculate the total number of pages based on the per_page size and entries count.
  """
  def pages(total_count) do
    (total_count / per_page())
    |> Float.ceil()
    |> Kernel.trunc()
  end
end
