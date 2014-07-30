defmodule Traitify.Client do
  use HTTPoison.Base
  use Traitify.Routes
  use Jazz

  import Traitify.Decoder

  def all(entity, args \\ []) when entity |> is_atom do
    route(entity, args) |> get |> response_body |> decode
  end

  def create(entity, body \\ %{}) when entity |> is_atom do
    route(entity) |> post(body) |> response_body |> decode
  end

  defp response_body(response), do: response.body

  @doc """
  process_url/1 is an override from HTTPoison.Base and uses the traitify config to construct a
  valid url.
  """
  def process_url(url) do
    config = Traitify.Config.Dev
    config.api[:host] <> config.api[:version] <> url
  end

  @doc """
  process_request_body/1 is an override from HTTPoison.Base and used to encode the struct to json
  """
  def process_request_body(body) do
    body |> JSON.encode!
  end
end
