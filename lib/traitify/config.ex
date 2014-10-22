defmodule Traitify.Config do
  use ExConf.Config

  config :api, host: host(Mix.env), secret: secret(Mix.env), version: "/v1"

  def host(:test), do: "http://example.com"
  def host(_), do: System.get_env("TRAITIFY_HOST")

  def secret(:test), do: "your_public_api_key___"
  def secret(_), do: System.get_env("TRAITIFY_SECRET")
end
