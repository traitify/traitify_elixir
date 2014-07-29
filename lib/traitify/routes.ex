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

      def route(:slides, [assessment_id: id]) do
        "/assessments/#{id}/slides"
      end
    end
  end
end
