defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input >= 1 do
    do_calc(input, 0)
  end

  defp do_calc(1, number), do: number
  defp do_calc(input, number) do
    case even?(input) do
      true ->
        input
        |> div(2)
        |> do_calc(number + 1)
      false ->
        input
        |> Kernel.*(3)
        |> Kernel.+(1)
        |> do_calc(number + 1)
    end
  end

  defp even?(num), do: rem(num, 2) == 0
end
