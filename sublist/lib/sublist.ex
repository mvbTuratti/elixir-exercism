defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([],[]), do: :equal
  def compare(_a, []), do: :superlist
  def compare([], _b), do: :sublist
  def compare(a, b) do
    tasks = [Task.async(fn -> Sublist.sublist(b,a, :sublist) end),
            Task.async(fn -> Sublist.sublist(a,b, :superlist) end)]

    r = Task.await_many(tasks) |> List.flatten()

    (Enum.all?(r, fn {_, v} -> v end) && :equal) ||
    (Keyword.get(r, :sublist) && :sublist) ||
    (Keyword.get(r, :superlist) && :superlist) ||
    :unequal
  end

  def sublist([], _,return), do: [{return, false}]
  def sublist([_|remainder] = l1 , l2, return) do
    case List.starts_with?(l1, l2) do
      true -> [{return, true}]
      false -> sublist(remainder, l2, return)
    end
  end

end
