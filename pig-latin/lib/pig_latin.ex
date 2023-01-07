defmodule PigLatin do
  @vowels [?a, ?e, ?i, ?o, ?u]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(<<letter::utf8, "y">>), do: "y#{<<letter>>}ay"
  def translate(word) do
    word
    |> String.split()
    |> Enum.reduce("", fn x, acc -> acc <> " " <> translate_word(x) end)
    |> String.trim()
  end

  defp translate_word(<<letter::utf8, _rest::binary>> = word) when letter in @vowels do
    word <> "ay"
  end
  defp translate_word(<<letter::utf8, "qu", rest::binary>>), do: rest <> <<letter>> <> "quay"
  defp translate_word(<<"qu", rest::binary>>), do: rest <> "quay"
  defp translate_word(<<letter::utf8, consonant::utf8, _rest::binary>> = word) when letter in ?x..?y and consonant not in @vowels, do: word <> "ay"
  defp translate_word(<<letter::utf8, rest::binary>>) when letter not in @vowels, do: do_translate(rest, <<letter>>)
  defp translate_word(word), do: word

  defp do_translate(<<>>, acc), do: acc <> "ay"
  defp do_translate(<<letter::utf8, _rest::binary>> = word, acc) when letter in @vowels or letter === ?y, do: word <> acc <> "ay"
  defp do_translate(<<letter::utf8, rest::binary>>, acc), do: do_translate(rest, acc <> <<letter>>)

end
