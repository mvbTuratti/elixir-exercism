defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    complete(number)
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    (for i <- range, into: "" , do: complete(i) <> "\n") |> String.replace(~r/.\z/s, "")
  end

  defp complete(v) do
    case v do
      0 -> phrase({"No more bottles", "no more bottles", "Go to the store and buy some more", "99 bottles"})
      1 -> phrase({"1 bottle", "1 bottle", "Take it down and pass it around", "no more bottles"})
      2 -> phrase({"2 bottles", "2 bottles", "Take one down and pass it around", "1 bottle"})
      v -> phrase({"#{v} bottles", "#{v} bottles", "Take one down and pass it around", "#{v - 1} bottles"})
    end
  end

  defp phrase({a,b,c,d}) do
    a <> " of beer on the wall, " <> b <> " of beer.\n" <> c <> ", " <> d <> " of beer on the wall.\n"
  end
end
