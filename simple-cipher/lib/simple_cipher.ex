defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  @spec encode(String.t(), String.t()) :: String.t() | {:error, String.t()}
  def encode(plaintext, <<>>) do
    key = generate_key(100)
    do_encode(plaintext, key, key, "")
  end
  def encode(plaintext, key) do
    do_encode(plaintext, key, key, "")
  end

  defp do_encode(<<>>, _, _, acc), do: acc
  defp do_encode(plaintext, <<>>, key, acc), do: do_encode(plaintext, key, key, acc)
  defp do_encode(_plaintext, <<letter::utf8, _::binary>>, _, _) when letter not in ?a..?z, do: {:error, "Key not allowed"}
  defp do_encode(<<head::utf8, tail::binary>>, <<letter::utf8, remainder::binary>>, key, acc) do
    letter = head + letter - ?a
    letter = if letter > ?z, do: letter - ?z + ?a - 1, else: letter
    do_encode(tail, remainder, key,  acc <> <<letter>>)
  end


  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  @spec decode(String.t(), String.t()) :: String.t() | {:error, String.t()}
  def decode(ciphertext, key) do
    do_decode(ciphertext, key, key, "")
  end

  defp do_decode(<<>>, _, _, acc), do: acc
  defp do_decode(plaintext, <<>>, key, acc), do: do_decode(plaintext, key, key, acc)
  defp do_decode(_plaintext, <<letter::utf8, _::binary>>, _, _) when letter not in ?a..?z, do: {:error, "Key not allowed"}
  defp do_decode(<<head::utf8, tail::binary>>, <<letter::utf8, remainder::binary>>, key, acc) do
    letter = head - letter + ?a
    letter = if letter < ?a, do: letter + ?z - ?a + 1, else: letter
    do_decode(tail, remainder, key, acc <> <<letter>>)
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  @spec generate_key(integer()) :: String.t()
  def generate_key(length) when is_integer(length) do
    1..length
    |> Enum.reduce("", fn _x, acc -> acc <> <<Enum.random(?a..?z)>> end)
  end
end
