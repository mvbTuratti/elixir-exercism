defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @dna_to_rna %{?G => 'C', ?C => 'G', ?T => 'A', ?A => 'U'}

  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.reduce('', fn letter, acc -> acc ++ @dna_to_rna[letter] end)
  end
end
