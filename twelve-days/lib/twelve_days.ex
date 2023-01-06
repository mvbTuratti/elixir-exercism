defmodule TwelveDays do
  @positions_english %{1 => "first", 2 => "second", 3 => "third", 4 => "fourth",
                      5 => "fifth", 6 => "sixth", 7 => "seventh", 8 => "eighth",
                      9 => "ninth", 10 => "tenth", 11 => "eleventh", 12 => "twelfth"}
  @presents ["a Partridge in a Pear Tree.", "two Turtle Doves, and ", "three French Hens, ",
            "four Calling Birds, ", "five Gold Rings, ", "six Geese-a-Laying, ",
            "seven Swans-a-Swimming, ", "eight Maids-a-Milking, ", "nine Ladies Dancing, ",
            "ten Lords-a-Leaping, ", "eleven Pipers Piping, ", "twelve Drummers Drumming, "]
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) when number > 0 and number < 13 do
    {phoem, _} = 1..number
          |> Enum.reduce({"", @presents}, fn _iter, {acc, [present | remainder]} -> {present <> acc, remainder} end)
    "On the #{get_position(number)} day of Christmas my true love gave to me: #{phoem}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.reduce("", fn x, acc -> acc <> verse(x) <> "\n" end)
    |> String.trim()
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1,12)
  end

  defp get_position(x), do: @positions_english[x]

end
