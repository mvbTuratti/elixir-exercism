defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @points %{ ?A => 1, ?E => 1, ?I => 1, ?O => 1, ?U => 1, ?L => 1, ?N => 1, ?R => 1, ?S => 1, ?T => 1,
             ?D => 2, ?G => 2,
             ?B => 3, ?C => 3, ?M => 3, ?P => 3,
             ?F => 4, ?H => 4, ?V => 4, ?W => 4, ?Y => 4,
             ?K => 5,
             ?J => 8, ?X => 8,
             ?Q => 10, ?Z => 10}


  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    do_score(word, 0)
  end

  defp do_score("", points), do: points
  defp do_score(<<c::utf8, remainder::binary>>, points) do
    cond do
      c in ?a..?z -> do_score(remainder, points + @points[c - 32])
      c in ?A..?Z -> do_score(remainder, points + @points[c])
      true -> do_score(remainder, points)
    end

  end
end
