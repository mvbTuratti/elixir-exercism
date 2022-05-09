defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """


  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    set_letters()
    |> do_panagram_check(sentence)
  end

  defp set_letters(), do: MapSet.new(?a..?z)
  defp do_panagram_check(set, <<>>), do: MapSet.size(set) === 0
  defp do_panagram_check(set, <<letter, remainder::binary>>) do
    letter = if letter in ?A..?Z, do: letter + 32, else: letter
    set
    |> MapSet.delete(letter)
    |> do_panagram_check(remainder)
  end

end
