defmodule Traitify.Deck do
  use Traitify.Client, path: "/decks", has_many: :badges

  defstruct id: "", name: "", personality_group: "", description: "", badges: [], slide_count: 0

  def merge_keys(keys, set) do
    merge_keys keys, set, %Traitify.Deck{}
  end
end
