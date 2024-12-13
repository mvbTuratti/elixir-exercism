defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, size) when size < 1, do: raise ArgumentError
  def largest_product("", _size), do: raise ArgumentError
  def largest_product(number_string, size) do
    if String.length(number_string) < size, do: raise ArgumentError
    queue = :queue.new()
    {top_value, _q, _size} = String.graphemes(number_string)
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(
        {0, queue, size},
        fn number, {top_value, current_queue, size} ->
          new_queue = :queue.in(number, current_queue)
          current_size = :queue.len(new_queue)
          case current_size === size do
            true ->
              value = :queue.to_list(new_queue) |> Enum.reduce(1, &*/2)
              new_top_value = if value > top_value, do: value, else: top_value
              {new_top_value, :queue.drop(new_queue), size}
            false ->
              {0, new_queue, size}
          end
        end
      )
    top_value
  end
end
