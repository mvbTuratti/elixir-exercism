defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(n) do
        Stream.resource(
          fn -> {n, 2} end,
          fn
            {1, _} -> {:halt, nil}
            {acc, prime} when prime * prime > acc -> {[acc], {1, acc}}
            {acc, prime} when rem(acc, prime) == 0 -> {[prime], {div(acc, prime), prime}}
            {acc, 2} -> {[], {acc, 3}}
            # {acc, prime} when rem(prime, 30) in [1, 23] -> {[], {acc, prime + 6}}
            # {acc, prime} when rem(prime, 30) in [7, 13, 19] -> {[], {acc, prime + 4}}
            {acc, prime} -> {[], {acc, prime + 2}}
          end,
          fn _ -> nil end
        )
        |> Enum.to_list()
      end
end
