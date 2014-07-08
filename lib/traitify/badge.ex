defmodule Traitify.Badge do
  use Traitify.Parser

  defstruct personality_type: "", description: "", image_small: "", image_medium: "", image_large: "",
            font_color: "", color_1: "", color_2: "", color_3: ""

  def merge_keys(keys, set) do
    merge_keys keys, set, %Traitify.Badge{}
  end
end
