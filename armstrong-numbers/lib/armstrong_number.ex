defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) when is_integer(number) do
    number == armstrong_checker(number, 0, [])
  end
  def valid?(_), do: false

  defp armstrong_checker(0, expoent, acc), do: Enum.reduce(acc, 0, fn element, acum -> acum + trunc(:math.pow(element, expoent)) end)
  defp armstrong_checker(number, expoent, acc) do
    division = div(number, 10)
    remainder = rem(number,10)
    armstrong_checker(division, expoent + 1, [remainder | acc])
  end

end
