defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite([word]), do: "And all for the want of a #{word}.\n"
  def recite([first | _] = strings) do
    acc = strings
      |> Enum.chunk_every(2,1,:discard)
      |> Enum.reduce("", fn [x,y], acc -> "#{acc}For want of a #{x} the #{y} was lost.\n" end)
    "#{acc}And all for the want of a #{first}.\n"
  end
end
