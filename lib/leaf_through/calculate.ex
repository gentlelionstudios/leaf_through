defmodule LeafThrough.Calculate do
  @default_per_page 10

  def per_page do
    Application.get_env(:leaf_through, :per_page, @default_per_page)
  end

  def starting_row(page) do
    (page - 1) * per_page()
  end
end
