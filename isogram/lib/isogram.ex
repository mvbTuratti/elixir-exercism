defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """

  #We could also pattern match per letter using <<>>
  #Which would be faster.
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    Regex.replace(~r/(\s|-)/, sentence, "")
    |> String.graphemes()
    |> Stream.map(&String.upcase/1)
    |> Enum.reduce_while(MapSet.new(), fn
      char, acc ->
        if MapSet.member?(acc, char), do: {:halt, false}, else: {:cont, MapSet.put(acc, char)}
      end)
    |> mapset?()
  end

  defp mapset?(false), do: false
  defp mapset?(_), do: true

end
