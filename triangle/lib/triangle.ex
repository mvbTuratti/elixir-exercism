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

  defp compare(x, _y, x), do: {:error, "side lengths violate triangle inequality"}
  defp compare(x, x, _z), do: {:ok, :isosceles}
  defp compare(x,y,z) do
    case x + z > y and y + z > x do
      true ->  {:ok, :scalene}
      false -> {:error, "side lengths violate triangle inequality"}
    end
  end

  defp equals(x,x), do: {:ok, :equilateral}
  defp equals(x,y) when x  > y, do: {:error, "side lengths violate triangle inequality"}
  defp equals(_x,_y), do: {:ok, :isosceles}
end
