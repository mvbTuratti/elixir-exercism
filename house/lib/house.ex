defmodule House do

  @rhymes {"house that Jack built.","malt that lay in the ",
    "rat that ate the ", "cat that killed the ", "dog that worried the ",
    "cow with the crumpled horn that tossed the ", "maiden all forlorn that milked the ",
    "man all tattered and torn that kissed the ", "priest all shaven and shorn that married the ",
    "rooster that crowed in the morn that woke the ", "farmer sowing his corn that kept the ",
    "horse and the hound and the horn that belonged to the "
  }
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) when is_integer(start) and is_integer(stop) and stop >= start and start > 0 do
    for number <- start..stop, into: "" do
      "#{do_recite(number - 1, "")}\n"
    end
  end

  defp do_recite(current, acc) when current >= 0 do
    acc = "#{acc}#{elem(@rhymes, current)}"
    do_recite(current - 1, acc)
  end
  defp do_recite(_, acc), do: "This is the #{acc}"
end
