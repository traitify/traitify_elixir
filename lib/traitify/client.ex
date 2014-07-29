defmodule Traitify.Routes do
  defmacro __using__(_opts) do
    quote do
      def route(:decks, _), do: "/decks"

      def route(:personality_types, [deck: deck]) do
        "/decks/#{deck}/personality_types"
      end

      def route(:assessments, [id: id]) do
        "/assessments/#{id}"
      end
    end
  end
end

defmodule Traitify.Client do
  use HTTPoison.Base
  use Traitify.Routes

  import Traitify.Parser

  def all(struct, args \\ []) do
    route(struct, args) |> request_body |> parse
  end

  defp request_body(path) do
    get(path).body
  end

  @doc """
    process_url/1 is an override from HTTPoison.Base and uses the traitify config to construct a
    valid url.
  """
  def process_url(url) do
    config = Traitify.Config.Dev
    config.api[:host] <> config.api[:version] <> url
  end
end
