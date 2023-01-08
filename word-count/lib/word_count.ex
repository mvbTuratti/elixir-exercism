defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.replace(~r/('([\_\w\d'-]+)'|[^\_\w\d'-]+)/u, sentence, "\\2 ")
    |> String.trim()
    |> String.downcase(:ascii)
    |> String.split(~r/(\s|\_)+/)
    |> Enum.frequencies()
  end
end
