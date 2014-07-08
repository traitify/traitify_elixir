defmodule Traitify.Config.Test do
  use ExConf.Config

  config :api, host: "http://example.com", version: "/v1", secret: "secret"
end
