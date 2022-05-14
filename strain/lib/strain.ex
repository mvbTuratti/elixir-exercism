defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_filtering(list, fun, true, [])
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_filtering(list, fun, false, [])
  end

  defp do_filtering([], _, _validator, acc), do: acc |> Enum.reverse()
  defp do_filtering([item | remainder], fun, validator, acc) do
    cond do
      fun.(item) == validator -> do_filtering(remainder, fun, validator, [item | acc])
      true -> do_filtering(remainder, fun, validator, acc)
    end
  end
end
