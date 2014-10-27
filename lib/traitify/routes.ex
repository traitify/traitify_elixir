defmodule Traitify.Routes do
  defmacro __using__(_opts) do
    quote do
      def route(:decks, _), do: "/decks"

      def route(:deck_personality_types, [deck: deck]) do
        "/decks/#{deck}/personality_types"
      end

      def route(:assessments, [id: id]) do
        "/assessments/#{id}"
      end
      def route(:assessments), do: "/assessments"

      def route(:slides, [assessment_id: id]) do
        "/assessments/#{id}/slides"
      end

      def route(:slides, [assessment_id: id, slide_id: slide_id]) do
        "/assessments/#{id}/slides/#{slide_id}"
      end

      def route(:personality_types, [assessment_id: id]) do
        "/assessments/#{id}/personality_types"
      end

      def route(:personality_traits, [assessment_id: id]) do
        "/assessments/#{id}/personality_traits/raw"
      end
    end
  end
end
