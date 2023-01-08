defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  #using classic recursive approach
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    do_encode(plaintext, 0, "")
  end

  #using Elixir's approach
  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.graphemes()
    |> Enum.reduce("", fn
      <<letter>>, acc when letter in ?a..?z->
          acc <> <<?z - letter + ?a>>
      " ", acc ->
          acc
      <<letter>>, acc ->
          acc <> <<letter>>
    end)
  end

  defp do_encode(<<>>, _, acc), do: acc
  defp do_encode(<<letter::utf8, rest::binary>>, count, acc) when letter in ?A..?Z, do: do_encode(<<letter+32>> <> rest, count, acc)
  defp do_encode(<<letter::utf8, rest::binary>>, count, acc) when letter in ?a..?z do
    encoded_letter = ?z - (letter - ?a)
    check_add_space(rest, count, acc, <<encoded_letter>>)
  end
  defp do_encode(<<letter::utf8, rest::binary>>, count, acc) when letter in ?0..?9, do: check_add_space(rest, count, acc, <<letter>>)
  defp do_encode(<<_letter::utf8, rest::binary>>, count, acc), do: do_encode(rest, count, acc)

  defp check_add_space(rest, 5, acc, letter), do: do_encode(rest, 1, "#{acc} #{letter}")
  defp check_add_space(rest, count, acc, letter), do: do_encode(rest, count + 1, acc <> letter)
end
