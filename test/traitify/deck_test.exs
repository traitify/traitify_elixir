defmodule Traitify.Client.Test do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Traitify.Deck

  test "retrieve all available decks" do
    use_cassette "decks", custom: true do
      decks = Deck.all
      assert 2 == Enum.count decks

      assert "career-deck" == List.first(decks).id
      assert "super-hero" == List.last(decks).id

      badges = List.first(decks).badges
      assert "Visionary" == List.first(badges).personality_type
    end
  end

end
