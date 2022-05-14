defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(:mercury, seconds), do: {:ok, earth_seconds_to_year(seconds) / 0.2408467}
  def age_on(:venus, seconds), do: {:ok, earth_seconds_to_year(seconds) / 0.61519726}
  def age_on(:earth, seconds), do: {:ok, earth_seconds_to_year(seconds)}
  def age_on(:mars, seconds), do: {:ok, earth_seconds_to_year(seconds) / 1.8808158 }
  def age_on(:jupiter, seconds), do: {:ok, earth_seconds_to_year(seconds) / 11.862615}
  def age_on(:saturn, seconds), do: {:ok, earth_seconds_to_year(seconds) / 29.447498}
  def age_on(:uranus, seconds), do: {:ok, earth_seconds_to_year(seconds) / 84.016846}
  def age_on(:neptune, seconds), do: {:ok, earth_seconds_to_year(seconds) / 164.79132}
  def age_on(_,_), do: {:error, "not a planet"}

  defp earth_seconds_to_year(sec), do: sec / 31557600

end
