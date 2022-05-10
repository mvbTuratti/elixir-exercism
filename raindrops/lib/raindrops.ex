defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    with str_pling <- pling(number),
         str_plang <- plang(str_pling, number),
         str_plong <- plong(str_plang, number),
         {:ok, result} <- checker(str_plong, number) do
      result
    else
      {:error, number} -> Integer.to_string(number)
    end
  end

  defp pling(number), do: if rem(number,3) === 0, do: "Pling", else: ""
  defp plang(acc, number), do: if rem(number,5) === 0, do: acc <> "Plang", else: acc
  defp plong(acc, number), do: if rem(number,7) === 0, do: acc <> "Plong", else: acc

  defp checker("", number), do: {:error, number}
  defp checker(acc, _number), do: {:ok, acc}
end
