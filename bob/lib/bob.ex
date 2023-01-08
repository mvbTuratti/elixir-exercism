defmodule Bob do
  @answers %{question: "Sure.", yell: "Whoa, chill out!",
            question_yelled: "Calm down, I know what I'm doing!",
            silence: "Fine. Be that way!", default: "Whatever.",
            number: "Whatever."}
  @russian [?У, ?Х, ?О, ?Д, ?И]
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    response = input
              |> String.to_charlist()
              |> Enum.reduce(:silence, fn x, acc -> check_response(acc, x) end)

    @answers[response]
  end

  defp check_response(:silence, letter)
              when letter in ?A..?Z
              when letter in @russian, do: :yell
  defp check_response(:yell, letter)
              when letter in ?A..?Z
              when letter in @russian, do: :yell
  defp check_response(:number, letter)
              when letter in ?A..?Z
              when letter in @russian, do: :yell

  defp check_response(_, letter) when letter in ?a..?z, do: :default

  defp check_response(:yell, ??), do: :question_yelled
  defp check_response(_, ??), do: :question
  defp check_response(:yell, letter) when letter in ?0..?9, do: :yell
  defp check_response(_, letter) when letter in ?0..?9, do: :number
  defp check_response(state, _), do: state

end
