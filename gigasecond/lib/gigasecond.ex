defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    current_time = %NaiveDateTime{year: year, month: month, day: day, hour: hours, minute: minutes, second: seconds}
    new_time = NaiveDateTime.add(current_time, 1_000_000_000, :second)
    {{new_time.year, new_time.month, new_time.day}, {new_time.hour, new_time.minute, new_time.second}}
  end
end
