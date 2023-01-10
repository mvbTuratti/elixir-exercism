defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @plants %{"V" => :violets, "R" => :radishes, "G" => :grass, "C" => :clover}
  @default_students ~w(alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry)a
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_students) do
    empty_map = Enum.reduce(student_names, %{}, fn atom, acc -> Map.put(acc, atom, {}) end)
    info_string
    |> String.split("\n")
    |> Stream.map(&String.graphemes/1)
    |> Stream.zip_with(&(&1))
    |> Stream.chunk_every(2,2,:discard)
    |> Enum.zip_reduce(ordered_named(student_names), empty_map,
        fn plants, atom, acc -> Map.put(acc, atom, plant_as_atoms(plants))
    end)

  end

  defp ordered_named(names), do: names |> Enum.sort()

  defp plant_as_atoms([[a,c],[b,d]]), do: {@plants[a], @plants[b], @plants[c], @plants[d]}
end
