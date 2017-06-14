defmodule LeafThrough.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app:               :leaf_through,
      version:           @version,
      elixir:            "~> 1.3",
      build_embedded:    Mix.env == :prod,
      start_permanent:   Mix.env == :prod,
      elixirc_paths:     elixirc_paths(Mix.env),
      deps:              deps(),
      description:       description(),
      package:           package(),
      test_coverage:     [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test), do: [:postgrex, :ex_machina] ++ applications(:dev)
  defp applications(:dev),  do: [:logger]
  defp applications(_all),  do: []

  defp deps do
    [
      {:ecto,        "~> 2.0"},
      {:ex_doc,      "~> 0.15",  only: :docs},
      {:excoveralls, "~> 0.6",   only: :test},
      {:ex_machina,  "~> 2.0",   only: :test},
      {:postgrex,    ">= 0.0.0", only: :test}
    ]
  end

  defp description do
    """
    Painless pagination for Ecto queries.
    """
  end

  defp package do
    [
      maintainers: ["Brian Gamble"],
      licenses:    ["Apache 2.0"],
      links:       %{"GitHub" => "https://github.com/gentlelionstudios/leaf_through"},
      files:       ~w(lib mix.exs README.md)
    ]
  end
end
