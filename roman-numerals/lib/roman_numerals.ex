defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    do_numeral(number, "")
  end

  defp do_numeral(0, acc), do: acc
  defp do_numeral(number, acc) when number >= 1000 do
    {remainder, str_return} = calculate_number_string(number, acc, 1000, "M")
    do_numeral(remainder, str_return)
  end
  defp do_numeral(number, acc) when number >= 900, do: do_numeral(number+100, acc <> "C")
  defp do_numeral(number, acc) when number >= 500 do
    {remainder, str_return} = calculate_number_string(number, acc, 500, "D")
    do_numeral(remainder, str_return)
  end
  defp do_numeral(number, acc) when number >= 400, do: do_numeral(number+100, acc <> "C")
  defp do_numeral(number, acc) when number >= 100 do
    {remainder, str_return} = calculate_number_string(number, acc, 100, "C")
    do_numeral(remainder, str_return)
  end
  defp do_numeral(number, acc) when number >= 90, do: do_numeral(number+10, acc <> "X")
  defp do_numeral(number, acc) when number >= 50 do
    {remainder, str_return} = calculate_number_string(number, acc, 50, "L")
    do_numeral(remainder, str_return)
  end
  defp do_numeral(number, acc) when number >= 40, do: do_numeral(number+10, acc <> "X")
  defp do_numeral(number, acc) when number >= 10 do
    {remainder, str_return} = calculate_number_string(number, acc, 10, "X")
    do_numeral(remainder, str_return)
  end
  defp do_numeral(number, acc) when number === 9, do: acc <> "IX"
  defp do_numeral(number, acc) when number >= 5 do
    {remainder, str_return} = calculate_number_string(number, acc, 5, "V")
    do_numeral(remainder, str_return)
  end
  defp do_numeral(number, acc) when number === 4, do: acc <> "IV"
  defp do_numeral(number, acc) when number >= 1 do
    {remainder, str_return} = calculate_number_string(number, acc, 1, "I")
    do_numeral(remainder, str_return)
  end

  defp calculate_number_string(number, string, value, letter) do
    division = div(number, value)
    remainder = rem(number, value)
    str_return = for _iter <- 1..division, into: "", do: letter
    {remainder, string <> str_return}
  end
end
