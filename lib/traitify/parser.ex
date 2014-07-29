defmodule Traitify.Parser do

  def parse([]), do: []
  def parse([h|t]) do
    [extract_keys(h) |> parse_keys(h) | parse(t)]
  end
  def parse(val) when val |> is_map do
    extract_keys(val) |> parse_keys(val)
  end
  def parse(val) when val |> is_binary, do: val
  def parse(_), do: nil

  defp merge(acc, [], _), do: acc
  defp merge(acc, [key|t], set) do
    key |> get(set) |> put(key, acc) |> merge(t, set)
  end

  defp get(key, set), do: fetch(key, set) |> parse
  defp put(val, key, acc) when key |> is_atom do
    Map.put acc, key, val
  end
  defp put(val, key, acc) do
    put val, String.to_atom(key), acc
  end

  defp parse_keys(keys, set), do: merge(%{}, keys, set)
  defp extract_keys(nil), do: []
  defp extract_keys(set) do
    Map.keys set
  end
  defp fetch(key, set), do: Map.fetch!(set, key)
end
