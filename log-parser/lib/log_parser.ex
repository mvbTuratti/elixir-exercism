defmodule LogParser do

  @spec valid_line?(String.t()) :: boolean()
  def valid_line?(line) do
    Regex.match?(~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/, line)
  end

  @spec split_line(String.t()) :: [String.t()]
  def split_line(line) do
    String.split(line, ~r/<[*~=-]*>/)
  end

  @spec remove_artifacts(String.t()) :: String.t()
  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line[0-9]+/i, line, "")
  end

  @spec tag_with_user_name(String.t()) :: String.t()
  def tag_with_user_name(line) do
    name = Regex.named_captures(~r/User(\s|\\n)+(?<name>[^\s\\n]+)/, line)
    return_phrase(name, line)
  end

  defp return_phrase(%{"name" => name}, phrase), do: "[USER] #{name} " <> phrase
  defp return_phrase(nil, phrase), do: phrase
end
