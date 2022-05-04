defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) when input_base >= 2 and output_base >= 2 do
    with  {:ok, value} <-  do_convert(digits, input_base, output_base, 0),
          {:ok, output} <- to_base(value, output_base, []) do
      {:ok, output}
    else
      {:error, msg} -> {:error, msg}
    end

  end
  def convert(_,_,output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_,input_base,_) when input_base < 2, do: {:error, "input base must be >= 2"}

  defp do_convert([], _input_base, _output_base, acc), do: {:ok, acc}
  defp do_convert([head | remainder], input_base, output_base, acc) do
    case satisfy_condition?(head, input_base) do
      true ->
        acc = acc * input_base + head
        do_convert(remainder, input_base, output_base, acc)
      false ->
        {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp to_base(0, _base, []), do: {:ok, [0]}
  defp to_base(0, _base, acc), do: {:ok, acc}
  defp to_base(value, base, acc) do
     quotient = div(value, base)
     remainder = rem(value, base)
     to_base(quotient, base, [remainder | acc])
  end

  defp satisfy_condition?(value, base) when value >= 0 and value < base, do: true
  defp satisfy_condition?(_,_), do: false
end
