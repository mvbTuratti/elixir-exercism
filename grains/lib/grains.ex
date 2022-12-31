defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) when is_integer(number) and number > 0 and number < 65 do
    {:ok, trunc(:math.pow(2,number - 1))}
  end
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    result = 1..64
            |> Enum.reduce(0, fn elem, acc ->
              {:ok, v} = square(elem)
              acc + v
            end)
    {:ok, result}
  end
end
