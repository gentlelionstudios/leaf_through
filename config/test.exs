use Mix.Config

config :leaf_through,
  repo: Test.Repo,
  per_page: 5

config :leaf_through, ecto_repos: [Test.Repo]

# configure test database
config :leaf_through, Test.Repo,
  adapter: Sqlite.Ecto2,
  database: "db/test.db",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn
