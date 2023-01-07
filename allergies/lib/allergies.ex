defmodule Allergies do
  import Bitwise
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    Stream.resource(
      fn -> {get_inverted_bits(flags), alergies()} end,
      fn
        {bits, allergies} when bits == [] or allergies == [] -> {:halt, nil}
        {[1| bits], [allergie | remainder]} -> {[allergie], {bits, remainder}}
        {[0 | bits], [_| r]} -> {[], {bits, r}}
      end,
      fn _ -> nil end)
    |> Enum.to_list()
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    allergies = list(flags)
    item in allergies
  end

  defp alergies(), do: ["eggs", "peanuts","shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats"]
  defp get_inverted_bits(flags), do: (flags &&& 255) |> Integer.digits(2) |> Enum.reverse()
end
