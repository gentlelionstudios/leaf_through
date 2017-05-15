# Leaf Through

[![Build Status](https://travis-ci.org/gentlelionstudios/leaf_through.svg?branch=master)](https://travis-ci.org/gentlelionstudios/leaf_through)  [![Hex.pm](https://img.shields.io/hexpm/v/leaf_through.svg)](https://hex.pm/packages/leaf_through)

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

## Usage

Let's assume you've created a `User` schema which has a `first_name`, `last_name`, `username`, and an `email_address`.  Here's how to get the first page of results that are sorted by the user's last name:
```elixir
User
|> order_by(desc: :last_name)
|> paginate(1)
```
