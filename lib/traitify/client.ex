defmodule Traitify.Client do
  defmacro __using__(opts) do
    quote do
      @path unquote(opts[:path])

      use HTTPoison.Base
      use Traitify.Parser, has_many: unquote(opts[:has_many])

      def all(path\\@path) do
        get(path).body |> __MODULE__.parse_set
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
  end
end
