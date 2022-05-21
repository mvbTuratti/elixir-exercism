defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    ceiling = tuple_size(numbers) - 1
    do_search(numbers, 0, ceiling, key)
  end

  defp do_search({}, _left, _right, _key), do: :not_found

  defp do_search(_tuple, left, right, _key) when left > right, do: :not_found
  defp do_search(tuple, left, right, key) do
    middle = div(left + right, 2)
    case elem(tuple, middle) do
      ^key ->
        {:ok, middle}
      n when n > key ->
        do_search(tuple, left, middle - 1, key)
      n when n < key ->
        do_search(tuple, middle + 1, right, key)
    end

  end

end
