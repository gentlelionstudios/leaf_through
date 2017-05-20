# Leaf Through

[![Build Status](https://travis-ci.org/gentlelionstudios/leaf_through.svg?branch=master)](https://travis-ci.org/gentlelionstudios/leaf_through)&nbsp;&nbsp;[![Coverage Status](https://coveralls.io/repos/github/gentlelionstudios/leaf_through/badge.svg?branch=master)](https://coveralls.io/github/gentlelionstudios/leaf_through?branch=master)&nbsp;&nbsp;[![Hex.pm](https://img.shields.io/hexpm/v/leaf_through.svg)](https://hex.pm/packages/leaf_through)&nbsp;&nbsp;[![Ebert](https://ebertapp.io/github/gentlelionstudios/leaf_through.svg)](https://ebertapp.io/github/gentlelionstudios/leaf_through)

Painless pagination for Ecto queries.

## Installation

Leaf Through is [available in Hex](https://hex.pm/packages/leaf_through) and can be installed
by adding `leaf_through` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:leaf_through, "~> x.y.z"}]
end
```

Add LeafThrough to your `repo.ex`:
```elixir
defmodule YourApp.Repo do
  use Ecto.Repo, otp_app: :your_app
  use LeafThrough
end
```

If you want to define the per page size (default is 10), add the following to your config:
```elixir
config :leaf_through,
  per_page: 5
```

## Usage

Let's assume you've created a `User` schema which has a `first_name`, `last_name`, `username`, and an `email_address`.  Here's how to get the first page of results that are sorted by the user's last name:
```elixir
@users = User
         |> order_by(desc: :last_name)
         |> paginate(1)
```

Here's how to add pagination links to one of your Phoenix templates:
```elixir
# In the template's view add
import LeafThrough.Html

# In the template file add
<%= raw(leaf_through(@users)) %>
```

