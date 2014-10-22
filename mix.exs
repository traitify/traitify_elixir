defmodule TraitifyElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :traitify_elixir,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
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
