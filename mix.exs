Code.ensure_loaded?(Hex) and Hex.start

defmodule TraitifyElixir.Mixfile do
  use Mix.Project

  def project do
    [ app: :traitify_elixir,
      version: "0.1.1",
      elixir: "~> 1.0.0",
      deps: deps,
      package: [
        files: ["lib", "mix.exs", "README*", "LICENSE*"],
        contributors: ["Johnny Winn"],
        licenses: ["Apache 2.0"],
        links: %{ "Github" => "https://github.com/traitify/traitify_elixir" }
      ],
    description: """
    An Elixir client library for the Traitify API
    """
  ]
  end

  def application do
    [applications: [:httpoison]]
  end

  defp deps do
    [
      {:exvcr, "~> 0.3.2"},
      {:ex_conf, "~> 0.1.3"},
      {:hackney, "~> 0.13.1"},
      {:httpoison, "~> 0.4.2"},
      {:poison, "~> 1.1.1"}
    ]
  end
end
