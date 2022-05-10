defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @proteins %{"UGU" => "Cysteine", "UGC" => "Cysteine", "UUA" => "Leucine",
              "UUG" => "Leucine", "AUG" => "Methionine", "UUU" => "Phenylalanine",
              "UUC" => "Phenylalanine", "UCU" => "Serine", "UCC" => "Serine",
              "UCA" => "Serine", "UCG" => "Serine", "UGG" => "Tryptophan",
              "UAU" => "Tyrosine", "UAC" => "Tyrosine"}
  @stopper ["UAA", "UAG", "UGA"]

  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(<<>>), do: {:ok, []}
  def of_rna(<<_a::8,_b::8,_c::8,_rest::binary>> = rna) do
    with  {:ok, acc} <- do_decode(rna, []) do
      {:ok, Enum.reverse(acc)}
    else
      :error -> {:error, "invalid RNA"}
    end
  end
  def of_rna(_rna), do: {:error, "invalid RNA"}

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(<<_a::8,_b::8,_c::8>> = codon) do
    cond do
      codon in @stopper -> {:ok, "STOP"}
      Map.has_key?(@proteins, codon) -> {:ok, @proteins[codon]}
      true -> {:error, "invalid codon"}
    end
  end
  def of_codon(_), do: {:error, "invalid codon"}


  defp do_decode(<<>>, acc), do: {:ok, acc}
  defp do_decode(<<a::8,b::8,c::8,rest::binary>>, acc) do
    codon = <<a,b,c>>
    cond do
      codon in @stopper -> {:ok, acc}
      Map.has_key?(@proteins, codon) -> do_decode(rest, [@proteins[codon] | acc ])
      true -> :error
    end
  end
  defp do_decode(_,_), do: :error
end
