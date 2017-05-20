defmodule LeafThrough.Mixfile do
  use Mix.Project

  @version "0.0.5"

  def project do
    [
      app:             :leaf_through,
      version:         @version,
      elixir:          "~> 1.3",
      build_embedded:  Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps:            deps(),
      description:     description(),
      package:         package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ecto,   "~> 2.0"},
      {:ex_doc, "~> 0.15.1", only: :docs},
      {:excoveralls, "~> 0.6.3", only: :test}
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
