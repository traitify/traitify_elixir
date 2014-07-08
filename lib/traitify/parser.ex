defmodule Traitify.Parser do
  defmacro __using__(opts) do
    has_many = opts[:has_many] |> Atom.to_string

    quote do
      def parse_set([]), do: []
      def parse_set([h|t]) do
        [Map.keys(h) |> __MODULE__.merge_keys h] ++ __MODULE__.parse_set(t)
      end

      def merge_keys([], _, acc), do: acc
      def merge_keys([key|t], set, acc) do
        new_key = String.to_atom key
        acc = Map.put acc, new_key, fetch_for(key, set)
        merge_keys(t, set, acc)
      end

      def fetch_for(unquote(has_many), parent) do
        Map.fetch!(parent, unquote(has_many)) |>
          Traitify.Badge.parse_set
      end

      def fetch_for(key, set) do
        Map.fetch!(set, key)
      end
    end
  end
end
