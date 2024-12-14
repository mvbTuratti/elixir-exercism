defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
    Task.async_stream(
      texts,
      fn text ->
        text
        |> String.downcase()
        |> String.graphemes()
        |> Enum.filter(fn e -> Regex.match?(~r/^[[:alpha:]]$/u, e) end)
        |> Enum.frequencies()
      end,
      max_concurrency: workers
    )
    |> Enum.reduce(%{},
      fn {:ok, map}, acc ->
        Map.merge(map, acc, fn _k, v1, v2 -> v1 + v2 end )
      end)
  end
end
