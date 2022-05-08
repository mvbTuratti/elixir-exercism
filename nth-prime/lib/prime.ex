defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(1), do: 2
  def nth(count) when count > 1 do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&(prime_helper/1))
    |> Enum.at(count - 2)
  end
  def nth(_), do: raise "there is no zeroth prime"

  defp prime_helper(number_to_be_checked) do
    2..number_to_be_checked - 1
    |> Enum.all?(fn y -> rem(number_to_be_checked, y) !== 0 end)
  end
end
