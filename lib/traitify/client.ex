defmodule Traitify.Client do
  use HTTPoison.Base

  import Traitify.Parser

  def all(struct) do
    struct |> to_path |> request_body |> parse
  end

  defp request_body(path) do
    get(path).body
  end

  defp to_path(struct), do: "/" <> Atom.to_string(struct)

  @doc """
    process_url/1 is an override from HTTPoison.Base and uses the traitify config to construct a
    valid url.
  """
  def process_url(url) do
     config = Traitify.Config.Dev
     config.api[:host] <> config.api[:version] <> url
  end
end
