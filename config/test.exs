use Mix.Config

config :leaf_through,
  per_page: 5

config :leaf_through, ecto_repos: [Test.Repo]

# configure test database
config :leaf_through, Test.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "leaf_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
