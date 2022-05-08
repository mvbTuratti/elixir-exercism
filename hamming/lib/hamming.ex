defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    do_hamming_distance(strand1, strand2, 0)
  end

  defp do_hamming_distance([], [], acc), do: {:ok, acc}
  defp do_hamming_distance([], _str2, _acc), do: {:error, "strands must be of equal length"}
  defp do_hamming_distance(_str1, [], _acc), do: {:error, "strands must be of equal length"}

  defp do_hamming_distance([fst_letter | fst_remainder], [snd_letter | snd_remainder], acc) do
    count = if fst_letter === snd_letter, do: acc, else: acc + 1
    do_hamming_distance(fst_remainder, snd_remainder, count)
  end
end
