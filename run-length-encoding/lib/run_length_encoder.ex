defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    do_encode(string, "", <<>>, 1)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    do_decode(string, "", nil, 0)
  end

  defp do_encode(<<>>, acc, letter, 1), do: acc <> <<letter>>
  defp do_encode(<<>>, acc, letter, number) do
    number = Integer.to_string(number)
    acc <> number <> <<letter>>
  end
  defp do_encode(<<char, rest::binary>>, acc, letter, number) do
    cond do
      char === letter ->
        do_encode(rest, acc, letter, number + 1)
      number === 1 ->
        do_encode(rest, acc <> <<letter>>, char, 1)
      true ->
        number = Integer.to_string(number)
        do_encode(rest, acc <> number <> <<letter>>, char, 1)
    end
  end

  defp do_decode(<<>>, acc, _previous_digit, _sum), do: acc
  defp do_decode(<<char, rest::binary>>, acc, previous_digit, sum) do
    with {:number, char} <- categorize_char(char),
         {:sum, number} <- sum_if_both_numbers(char, previous_digit, sum) do
          do_decode(rest, acc, char, number)
    else
      {:not_number, char} ->
        repeating = for _ <- 0..sum, into: "" , do: <<char>>
        do_decode(rest, acc <> repeating, char, 0)
      {:not_sum, number} ->
        do_decode(rest, acc, char, String.to_integer(<<number>>))
    end
  end

  defp categorize_char(char), do: if char in ?0..?9, do: {:number, char}, else: {:not_number, char}

  defp sum_if_both_numbers(number, previous_char, sum) do
    case categorize_char(previous_char) do
      {:number, _char} -> {:sum, sum * 10 + String.to_integer(<<number>>)}
      {:not_number, _char} -> {:not_sum, number}
    end
  end
end
