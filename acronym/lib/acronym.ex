defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    pattern = :binary.compile_pattern([" ", "-", "_"])
    string
    |> String.split(pattern)
    |> Stream.filter(&is_word?/1)
    |> Stream.filter(&String.trim/1)
    |> Stream.map(&String.at(&1, 0))
    |> Stream.map(&String.upcase/1)
    |> Enum.reduce(fn x, acc -> acc <> x end)
  end

  @spec is_word?(String.t()) :: boolean()
  defp is_word?(word) do
    String.match?(word, ~r/\w/u)
  end
end
