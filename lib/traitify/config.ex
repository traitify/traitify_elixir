defmodule Traitify.Config.Dev do
  use ExConf.Config

  @host System.get_env("TRAITIFY_HOST") || "http://example.com"
  @secret System.get_env("TRAITIFY_SECRET") || "super_secret__"

  config :api, host: @host, secret: @secret, version: "/v1"
end
