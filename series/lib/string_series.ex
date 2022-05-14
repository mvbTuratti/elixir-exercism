defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size < 1, do: []
  def slices(s, size) do
    case String.length(s) do
      len when len > size -> []
      _len -> Regex.scan(~r/\w{1,#{size}}/u, s) |> List.flatten()
    end
  end

end
