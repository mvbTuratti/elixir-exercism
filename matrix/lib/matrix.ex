defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) when is_binary(input) do
    lines = input
            |> String.split("\n")
            |> Enum.map(fn x -> String.split(x," ") |> Enum.map(&(String.to_integer/1)) end)
    cols = lines |> Enum.zip_with(&(&1))
    %Matrix{matrix: %{rows: lines, cols: cols, str: input}}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%{matrix: %{str: string}}) do
    string
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%{matrix: %{rows: rows}}) do
    rows
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%{matrix: %{rows: rows}}, index) when is_integer(index) and index >= 1 do
    rows
    |> Enum.at(index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%{matrix: %{cols: cols}}) do
    cols
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%{matrix: %{cols: cols}}, index) when is_integer(index) and index >= 1 do
    cols
    |> Enum.at(index - 1)
  end
end
