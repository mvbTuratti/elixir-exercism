defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) when is_integer(num) and num > 0 do
    do_rows(1, num, [])
  end

  defp do_rows(1, 1, _), do: [[1]]
  defp do_rows(1, 2, _), do: [[1],[1,1]]
  defp do_rows(x, y, _) when x < 2, do: do_rows(2, y, [[1],[1,1]])
  defp do_rows(x, x, acc), do: acc
  defp do_rows(x, y, acc) do
    current = Enum.at(acc, x - 1)
    values = current |> Enum.chunk_every(2,1, :discard) |> Enum.map(&Enum.sum/1)
    row = [1 | values ++ [1]]
    do_rows(x + 1, y, acc ++ [row])
  end

end
