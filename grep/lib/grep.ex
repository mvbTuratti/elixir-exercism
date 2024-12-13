defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    regex_pattern = create_regex_pattern(pattern, flags)
    modifiers = return_modifiers(flags)
    add_file_name = should_add_file_name?(files)
    Enum.reduce(
      files,
      "",
      fn file, acc ->
        text = return_content_by_file_line(file, regex_pattern, modifiers, add_file_name)
              |> Enum.join()
        acc <> text
      end
    )
  end
  defp create_regex_pattern(pattern, flags) do
    Enum.filter(flags, fn element -> element != "-n" and element != "-l" and element != "-v" end)
    |> Enum.sort()
    |> apply_filter(pattern)
  end

  defp apply_filter([], pattern), do: ~r/#{pattern}/u
  defp apply_filter(["-i"], pattern), do: ~r/#{pattern}/iu
  defp apply_filter(["-x"], pattern), do: ~r/^#{pattern}$/u
  defp apply_filter(["-i", "-x"], pattern), do: ~r/^#{pattern}$/iu

  defp return_modifiers(flags) do
    Enum.reduce(
      flags,
      {false, false, false},
      fn flag, {only_name, only_non_matches, add_line_info} ->
        case flag do
          "-l" -> {true, only_non_matches, add_line_info}
          "-v" -> {only_name, true, add_line_info}
          "-n" -> {only_name, only_non_matches, true}
          _ -> {only_name, only_non_matches, add_line_info}
        end
      end
    )
  end
  defp should_add_file_name?([_first | [_second | _remainder]]), do: true
  defp should_add_file_name?(_), do: false

  defp xor(x, x), do: false
  defp xor(_x, _y), do: true

  defp return_content_by_file_line(file, pattern, {only_name, only_non_matches, add_line_info}, add_file_name) do
    {text, _} = File.read!(file)
                |> String.split("\n")
                |> Enum.reduce_while(
                  {[], 1},
                  fn line, {text, line_number} = acc ->
                    matched = ( String.match?(line, pattern) |> xor(only_non_matches) ) and line !== ""
                    case matched do
                      true ->
                        continues_or_halt(only_name, add_line_info, add_file_name, file, line, acc)
                      false ->
                        {:cont, {text, line_number + 1}}
                    end
                  end
                )
    Enum.reverse(text)
  end

  defp continues_or_halt(only_name, add_line_info, add_file_name, file, line,{text, line_number}) do
    case only_name do
      true ->
        {:halt, {[file <> "\n" | text], line_number}}
      false ->
        line_modified =
          (if add_file_name, do: "#{file}:", else: "") <>
          (if add_line_info, do: "#{line_number}:", else: "") <>
          "#{line}\n"
        {:cont, {[line_modified | text], line_number + 1}}
    end
  end

end
