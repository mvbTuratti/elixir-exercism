defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(number) when is_integer(number) and number > 1 do
    do_factors(number, 2, [])
    |> Enum.reverse()
  end


  defp do_factors(1, _, acc), do: acc
  defp do_factors(x, y, acc) do
    if rem(x,y) == 0, do: do_factors(div(x,y), y, [y | acc]), else: do_factors(x, y + 1, acc)
  end

end
