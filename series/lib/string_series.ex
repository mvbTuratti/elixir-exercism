defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size < 1, do: []
  def slices(s, size) do
    length = String.length(s)
    do_slices(s, size, [], length)
  end

  defp do_slices(_,size, _, length) when length < size, do: []
  defp do_slices(word, size, acc, length) when length === size, do: [return_a_combination(size, word) | acc ] |> IO.inspect() |> Enum.reverse()
  defp do_slices(<<_c::utf8, rest::binary>> = word, size, acc, length) do
    do_slices(rest, size, [return_a_combination(size, word) | acc], length - 1)
  end

  defp return_a_combination(size, word) do
    [combination] = Regex.run(~r/\w{1,#{size}}/u, word)
    combination
  end
end
