defmodule TopSecret do
  def to_ast(string) do
    ast_map =check_ast(string)
    params = Regex.split(~r/,/u, ast_map["params"])
    {String.to_atom(ast_map["func"]), [line: 1], (for i <- params, do: (check_ast(i) && to_ast(i)) || i )}
  end

  def decode_secret_message_part(ast, acc) do
    # Please implement the decode_secret_message_part/2 function
  end

  def decode_secret_message(string) do
    # Please implement the decode_secret_message/1 function
  end

  defp check_ast(str) do
    Regex.named_captures(~r|(?<func>[A-Za-z0-9_?!]{1,})\((?<params>[A-Za-z0-9,_]{1,})|u, str)
  end
end
