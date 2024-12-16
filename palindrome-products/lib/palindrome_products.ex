defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    if min_factor > max_factor, do: raise ArgumentError
    get_pairs(min_factor, max_factor)
      |> Task.async_stream(fn [x,y] ->
        total = x*y
        case is_palindrome?(total) do
          true ->
            {[x,y], total}
          false ->
            {[], -1}
        end
      end)
      |> Enum.reduce(%{}, fn {:ok, {pair, value}}, acc ->
        cond do
          value > 0 ->
            {_, r} = Map.get_and_update(acc, value,fn current_value ->
                new_value = if current_value !== nil, do: [pair | current_value], else: [pair]
                {current_value, new_value}
              end)
            r
          true ->
            acc
        end
      end)
  end
  defp get_pairs(min_factor, max_factor) do
    ( for n <- min_factor..max_factor, m <- min_factor..max_factor, into: [], do: [n,m] ) |> Enum.filter(fn [x,y] -> x <= y end )
  end
  defp is_palindrome?(value) when value < 10, do: true
  defp is_palindrome?(value) do
    string_number = Integer.to_string(value)
    second_half = string_number |> String.reverse()
    string_number === second_half
  end

end
