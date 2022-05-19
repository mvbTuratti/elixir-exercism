defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a > 0 and b > 0 and c > 0 do
    [a,b,c]
    |> Enum.reduce(fn
        x, {:equal, y} -> equals(x,y)
        x, {:dif, {y, z}} -> compare(x,y,z)
        x, y ->
          cond do
            x === y -> {:equal, y}
            x > y -> {:dif, {x, y}}
            true -> {:dif, {y, x}}
          end
      end
      )
  end

  def kind(_,_,_), do: {:error, "all side lengths must be positive"}

  defp compare(x, _y, z) when x === z, do: {:error, "side lengths violate triangle inequality"}
  defp compare(x, y, _z) when x === y, do: {:ok, :isosceles}
  defp compare(x,y,z) when x > y, do: if y + z >= x, do: {:ok, :scalene}, else: {:error, "side lengths violate triangle inequality"}
  defp compare(x,y,z), do: if x + z >= y, do: {:ok, :scalene}, else: {:error, "side lengths violate triangle inequality"}

  defp equals(x,y) when x === y, do: {:ok, :equilateral}
  defp equals(x,y) when x  > y, do: {:error, "side lengths violate triangle inequality"}
  defp equals(_x,_y), do: {:ok, :isosceles}
end
