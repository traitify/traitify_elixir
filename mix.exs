defmodule TraitifyElixir.Mixfile do
  use Mix.Project

  def project do
    [app: :traitify_elixir,
     version: "0.0.1",
     elixir: "~> 0.14.2",
     deps: deps(Mix.env)]
  end

  def application do
    [applications: []]
  end

  defp deps(:test) do
    [ {:exvcr, github: "parroty/exvcr"}] ++ deps(:prod)
  end

  defp deps(_) do
    [
      {:ex_conf, "~> 0.1.2"},
      {:hackney, github: "benoitc/hackney"},
      {:httpoison, "~> 0.3.0"}
    ]
  end
end
