defmodule Squares do
  @moduledoc """
  Calculate sum of squares, square of sum, difference between two sums from 1 to a given end number.

  F1(N) = 1 + 2 + ... + N = N * (N+1) / 2
  F2(N) = 1^2 + 2^2 + ... + N^2 = N * (N+1) * (2*N+1) / 6
  """

  @doc """

  Calculate sum of squares from 1 to a given end number.
  """
  @spec sum_of_squares(pos_integer) :: pos_integer
  def sum_of_squares(number) do
    trunc(number * (number + 1) * (2 * number + 1) / 6)
  end

  @doc """
  Calculate square of sum from 1 to a given end number.
  """
  @spec square_of_sum(pos_integer) :: pos_integer
  def square_of_sum(number) do
    number * (number + 1) / 2
    |> :math.pow(2)
    |> trunc()
  end

  @doc """
  Calculate difference between sum of squares and square of sum from 1 to a given end number.
  """
  @spec difference(pos_integer) :: pos_integer
  def difference(number) do
    square_of_sum(number) - sum_of_squares(number)
  end
end
