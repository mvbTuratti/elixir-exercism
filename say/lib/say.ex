defmodule Say do
  @english %{0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six",
            7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten", 11 => "eleven", 12 => "twelve",
            13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
            18 => "eighteen", 19 => "nineteen", 20 => "twenty", 30 => "thirty", 40 => "forty",
            50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"
            }
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(n) when n < 0 or n > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(number) do
    case get_number(number) do
      nil ->
        phrase = Stream.resource(
            fn -> number end,
            fn
              0 -> {:halt, nil}
              number when number >= 1_000_000_000 ->
                {["#{formatting(div(number, 1_000_000_000), <<>>)} billion"], rem(number, 1_000_000_000)}
              number when number >= 1_000_000 ->
                {["#{formatting(div(number, 1_000_000), <<>>)} million"], rem(number, 1_000_000)}
              number when number >= 1_000 ->
                {["#{formatting(div(number, 1_000), <<>>)} thousand"], rem(number, 1_000)}
              number ->
                {[formatting(number, <<>>)], 0}
            end,
            fn _ -> nil end)
          |> Enum.reduce("", fn x, acc -> acc <> " " <> x end )
          |> String.trim()
        {:ok, phrase}
      exist -> {:ok, exist}
    end
  end

  defp formatting(0, acc), do: acc
  defp formatting(number, _acc) when number > 99 do
     hundred = div(number, 100)
     remainder = rem(number, 100)
     formatting(remainder, get_number(hundred) <> " hundred ")
  end
  defp formatting(number, acc) when number >= 9 do
    value = get_number(number) || get_number(div(number, 10) * 10) <> "-" <> get_number(rem(number, 10))
    acc <> value
  end
  defp formatting(number, acc), do: acc <> get_number(number)

  defp get_number(number), do: @english[number]
end
