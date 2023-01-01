defmodule ResistorColorTrio do
  @colors %{black: 0,
            brown: 1,
            red: 2,
            orange: 3,
            yellow: 4,
            green: 5,
            blue: 6,
            violet: 7,
            grey: 8,
            white: 9}
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([first, second, third]) do
    expoent = :math.pow(10, @colors[third]) |> trunc()
    value = (@colors[first] * 10 + @colors[second]) * expoent
    if value >= 1000, do: {div(value, 1000), :kiloohms}, else: {value, :ohms}
  end
end
