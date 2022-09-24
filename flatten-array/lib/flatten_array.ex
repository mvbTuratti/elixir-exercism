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
  def flatten(list) do
    do_flatten(list)
  end

  defp do_flatten(list) do
    for item when item != nil <- list do
      case item do
        [_val] ->
          do_flatten(item)
        val ->
          val
      end
    end
  end


end
