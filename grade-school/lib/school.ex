defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    %{}
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    case Map.has_key?(school, name) do
      true ->
        {:error, school}
      false ->
        {:ok, Map.put(school, name, grade)}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> Enum.reduce([], fn
      {name, value}, acc when grade == value -> [name | acc]
      {_, _}, acc -> acc
    end)
    |> Enum.reverse()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.reduce(%{}, fn
      {name, grade}, acc ->
        {_values, new} =
          Map.get_and_update(acc, grade,
          fn current_value ->
            result = (current_value && [name | current_value]) || [name]
            {current_value, result}
        end)
        new
    end)
    |> Enum.reduce([], fn
      {_grade, name_list}, acc -> [name_list | acc]
    end)
    |> List.flatten()
    |> Enum.reverse()
  end
end
