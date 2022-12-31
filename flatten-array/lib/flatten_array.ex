defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []
  #Simple solution using high level Elixir libs
  # def flatten(list) do
  #   List.flatten(list)
  #   |> Enum.filter(&(&1))
  # end

  def flatten([head | remainder]) do
    do_flatten(head, remainder, [])
    |> Enum.reverse()
  end

  defp do_flatten([], [], acc), do: acc
  defp do_flatten([], [h | t], acc), do: do_flatten(h, t, acc)
  defp do_flatten(nil, [], acc), do: acc
  defp do_flatten(nil, [h | t], acc), do: do_flatten(h, t, acc)
  defp do_flatten([nil], [], acc), do: acc
  defp do_flatten([nil | [h | []]], r, acc), do: do_flatten(h, r, acc)
  defp do_flatten([nil | [h | t]], r, acc), do: do_flatten(h, [t | r], acc)
  defp do_flatten([h | []], r, acc), do: do_flatten(h, r, acc)
  defp do_flatten([h | t], r, acc), do: do_flatten(h, [t | r], acc)
  defp do_flatten(v, [], acc), do: [v | acc]
  defp do_flatten(v, [h | t], acc), do: do_flatten(h, t, [v | acc])

end
