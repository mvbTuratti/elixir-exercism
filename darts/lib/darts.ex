defmodule Darts do
  @type position :: {number, number}

  @points %{outside: 0, outer: 1, middle: 5, inner: 10}
  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    :math.pow(x,2) + :math.pow(y,2)
    |> :math.sqrt()
    |> radius()
  end

  defp radius(val) when val > 10.0, do: @points[:outside]
  defp radius(val) when val > 5.0, do: @points[:outer]
  defp radius(val) when val > 1.0, do: @points[:middle]
  defp radius(_), do: @points[:inner]

end
