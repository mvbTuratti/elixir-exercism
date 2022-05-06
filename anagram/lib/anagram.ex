defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = String.downcase(base)
    ordened_letters = return_ordered_codepoints(base)

    candidates
    |> Enum.map(fn candidate ->
        candidate_lower = String.downcase(candidate)
        case candidate_lower do
          ^base ->
            false
          _ ->
            return_ordered_codepoints(candidate_lower)
            |> returns_word_if_equal(ordened_letters, candidate)
        end
      end)
    |> Enum.filter(&(&1))
  end

  defp return_ordered_codepoints(as_string) do
    as_string
    |> String.codepoints()
    |> Enum.sort()
  end

  defp returns_word_if_equal(sorted_codepoints_check, sorted_codepoints_base, word) do
    if sorted_codepoints_base == sorted_codepoints_check, do: word, else: false
  end
end
