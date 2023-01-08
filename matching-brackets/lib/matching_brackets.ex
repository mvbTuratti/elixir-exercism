defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @brackets_opener [?(, ?{, ?[ ]
  @brackets_closer %{?) => ?(, ?} => ?{, ?] => ?[}

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    do_check_brackets(str, [])
  end

  defp do_check_brackets(<<>>, []), do: true
  defp do_check_brackets(<<>>, _), do: false
  defp do_check_brackets(<<char::utf8, remainder::binary>>, []) do
    cond do
      char in @brackets_opener ->
        do_check_brackets(remainder, [char])
      char in list_closing_brackets() ->
        false
      true ->
        do_check_brackets(remainder, [])
    end
  end
  defp do_check_brackets(<<char::utf8, remainder::binary>>, [bracket | rest] = stack) do
    cond do
      char in @brackets_opener ->
        do_check_brackets(remainder, [char | stack])
      char in list_closing_brackets() ->
        if @brackets_closer[char] == bracket, do: do_check_brackets(remainder, rest), else: false
      true ->
        do_check_brackets(remainder, stack)
    end

  end

  defp list_closing_brackets(), do: Map.keys(@brackets_closer)
end
