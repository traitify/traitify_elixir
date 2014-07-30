defmodule Traitify.Client.Test do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Traitify.Client

  test "retrieve all available decks" do
    use_cassette "decks", custom: true do
      decks = Client.all(:decks)
      assert 2 == decks |> Enum.count

      assert "career-deck" == List.first(decks).id
      assert "super-hero" == List.last(decks).id

      badges = List.first(decks).badges
      assert "Visionary" == List.first(badges).personality_type
    end
  end

  test "retrieve personality types by deck ordered by name" do
    use_cassette "deck_personality_types", custom: true do
      personality_types = Client.all(:deck_personality_types, deck: "career-deck")
      assert 7 == personality_types |> Enum.count

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

  test "retrieve slides for assessment" do
    use_cassette "slides", custom: true do
      slides = Client.all(:slides, assessment_id: "6b546d14-5c4c-42c6-b146-49ff40d87a7d")
      assert 3 == slides |> Enum.count

      assert "Alphabetical Order" == List.first(slides).caption
    end
  end

  test "create a new assessment" do
    use_cassette "new_assessment", custom: true do
      assessment = Client.create(:assessments, %{deck_id: "career-deck"})

      assert "6b546d14-5c4c-42c6-b146-49ff40d87a7d" == assessment.id
    end
  end

  test "update an assessment slide" do
    use_cassette "update_slide", custom: true do
      slide = Client.update(:slides, %{response: true, time_taken: 2},
                                      assessment_id: "6b546d14-5c4c-42c6-b146-49ff40d87a7d",
                                      slide_id: "8ea9fad0-f65a-491a-adc6-0ae893b07734")

      assert "8ea9fad0-f65a-491a-adc6-0ae893b07734" == slide.id
      assert slide.response
      assert 2 == slide.time_taken
    end
  end

  test "bulk update an assessment slide" do
    use_cassette "bulk_update_slides", custom: true do
      slides = [
        %{id: "8ea9fad0-f65a-491a-adc6-0ae893b07734", response: true, time_taken: 2},
        %{id: "338e97c3-2ab3-47db-870b-b6becc09bb8f", response: false, time_taken: 1},
        %{id: "0ee906a9-ccd9-48eb-8d07-28dd2ea199cb", response: false, time_taken: 1},
      ]
      results = Client.update(:slides, slides, assessment_id: "6b546d14-5c4c-42c6-b146-49ff40d87a7d")

      first_slide = results |> List.first
      last_slide = results |> List.last

      assert "8ea9fad0-f65a-491a-adc6-0ae893b07734" == first_slide.id
      assert first_slide.response
      assert 2 == first_slide.time_taken

      assert "846671a6-530d-4b8e-a012-fc45ec5a045e" == last_slide.id
      assert nil == last_slide.response
      assert nil == last_slide.time_taken
    end
  end
end
