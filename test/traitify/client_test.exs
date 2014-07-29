defmodule Traitify.Client.Test do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Traitify.Client

  test "retrieve all available decks" do
    use_cassette "decks", custom: true do
      decks = Client.all(:decks)
      assert 2 == Enum.count decks

      assert "career-deck" == List.first(decks).id
      assert "super-hero" == List.last(decks).id

      badges = List.first(decks).badges
      assert "Visionary" == List.first(badges).personality_type
    end
  end

  test "retrieve personality types by deck ordered by name" do
    use_cassette "deck_personality_types", custom: true do
      personality_types = Client.all(:personality_types, deck: "career-deck")
      assert 7 == Enum.count personality_types

      assert "Action Taker" == List.first(personality_types).name
      assert "Visionary" == List.last(personality_types).name

      badge = List.first(personality_types).badge
      assert "fff" == badge.font_color
    end
  end

  test "retrieve an assessment by id" do
    use_cassette "assessments", custom: true do
      assessment = Client.all(:assessments, id: "6b546d14-5c4c-42c6-b146-49ff40d87a7d")

      assert "6b546d14-5c4c-42c6-b146-49ff40d87a7d" == assessment.id
      assert "career-deck" == assessment.deck_id
    end
  end

end
