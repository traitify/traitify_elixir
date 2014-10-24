defmodule Traitify.Client do
  use HTTPoison.Base
  use Traitify.Routes

  @doc """

  To retrieve mapped entities use `all/2`. It will return one or many depending
  on the entity type and args.

  """
  @spec all(Atom.t, Keyword.t) :: Keyword.t
  def all(entity, args \\ []) when entity |> is_atom do
    route(entity, args) |> get_request |> response_body
  end

  @doc """

  To create a new entity use `create/2`. This function takes the entity and
  the body as a map.

  """
  @spec create(Atom.t, Map.t) :: Map.t
  def create(entity, body \\ %{}) when entity |> is_atom do
    route(entity) |> post_request(body) |> response_body
  end

  @doc """

  To update an existing entity use `update/3`. This function takes the entity,
  the body as a map, and any args.

  """
  @spec update(Atom.t, Map.t, Keyword.t) :: Map.t
  @spec update(Atom.t, Map.t, Keyword.t) :: Keyword.t
  def update(entity, body \\ %{}, args \\ []) when entity |> is_atom do
    route(entity, args) |> put_request(body) |> response_body
  end

  defp response_body(response), do: response.body

  defp get_request(path), do: get(path, [], hackney_options)
  defp post_request(path, body), do: post(path, body, [], hackney_options)
  defp put_request(path, body), do: put(path, body, [], hackney_options)

  @doc """
  process_url/1 is an override from HTTPoison.Base and uses the traitify config to construct a
  valid url.
  """
  def process_url(url) do
    config = Traitify.Config
    config.api[:host] <> config.api[:version] <> url
  end

  @doc """
  process_request_body/1 is an override from HTTPoison.Base and used to encode the struct to json
  """
  def process_request_body(body) do
    Poison.Encoder.encode(body, []) |> IO.iodata_to_binary
  end

  @doc """
  process_request_headers/1 is an override from HTTPoison.Base and used to set the request content-type
  """
  def process_request_headers(headers) do
    headers ++ [{"Content-Type", "application/json"}]
  end

  @doc """
  process_response_body/1 is an override from HTTPoison.Base and used to decode the response
  """
  def process_response_body(body) do
    body
  end

  defp hackney_options do
    config = Traitify.Config
    [hackney: [basic_auth: { config.api[:secret], "x" }]]
  end
end
