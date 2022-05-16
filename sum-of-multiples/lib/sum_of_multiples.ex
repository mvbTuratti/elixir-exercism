defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    0..limit - 1
    |> Stream.filter(&(factorial?(&1, factors, limit)))
    |> Enum.sum()
  end

  defp factorial?(number, factors, limit) do
    factors
    |> Enum.filter(&(&1 <= limit))
    |> Enum.any?(fn
        0 -> false
        x when x <= limit-> rem(number, x) === 0
      end)
  end

end
