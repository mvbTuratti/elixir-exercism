defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(string) do
    do_encode(string, "", nil, 1)
  end

  defp do_encode(<<>>, acc, letter, 1), do: "#{acc}#{<<letter>>}"
  defp do_encode(<<>>, acc, letter, number), do: "#{acc}#{number}#{<<letter>>}"
  defp do_encode(<<char, rest::binary>>, acc, letter, number) do
    cond do
      char === letter ->
        do_encode(rest, acc, char, number + 1)
      !letter ->
        do_encode(rest, acc, char, 1)
      number === 1 ->
        do_encode(rest, "#{acc}#{<<letter>>}", char, 1)
      true ->
        do_encode(rest, "#{acc}#{number}#{<<letter>>}", char, 1)
    end
  end


  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.split(~r/[^0-9]{1,}/, include_captures: true)
    |> Enum.map(fn x ->
      case Integer.parse(x) do
        {num, ""} -> num
        _ -> x
      end
    end)
    |> do_decode("")
  end

  defp do_decode([], acc), do: acc
  defp do_decode([head | remainder], acc) when is_integer(head) do
    [h | r] = remainder
    <<c::utf8, rest::binary>> = h
    new_char = for _ <- 1..head, into: "" , do: <<c>>
    do_decode(r, acc <> new_char <> rest)
  end
  defp do_decode([head | remainder], acc), do: do_decode(remainder, acc <> head)
end
