defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> String.replace(~r/-/, "")
    |> String.graphemes()
    |> Enum.reduce_while({10, 0}, fn
      "X", {1, acc} -> {:cont, {0, acc + 10}}
      "X", {_, _acc} -> {:halt, {-1, 0}}
      <<char>>, {_, _acc} when char not in ?0..?9 -> {:halt, {-1, 0}}
      digit, {1, acc} -> {:cont, {0, acc + String.to_integer(digit)}}
      digit, {iter, acc} when iter > 1 ->
        number = String.to_integer(digit)
        {:cont, {iter - 1, acc + iter * number}}
      _, _ -> {:halt, {-1, 0}}
    end)
    |> check_operations()
  end

  defp check_operations({0, value}), do: rem(value,11) == 0
  defp check_operations({_x, _value}), do: false
end
