defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when not is_integer(number), do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(1), do: {:ok, :deficient}
  def classify(n), do: {:ok, do_classify(n, 1, 0)}

  defp do_classify(x, x, x), do: :perfect
  defp do_classify(x, x, acc) when acc > x, do: :abundant
  defp do_classify(x, x, _), do: :deficient
  defp do_classify(stop, current, acc) do
    #check if current number does divede and if it does add to the accumulator
    acc = if rem(stop, current) == 0, do: acc + current, else: acc
    do_classify(stop, current + 1, acc)
  end

end
