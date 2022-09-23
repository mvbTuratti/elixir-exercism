defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    Integer.floor_div(score - 10, 2)
  end

  @spec ability :: pos_integer()
  def ability do
    Enum.random(3..18)
  end

  @spec character :: t()
  def character do
    constitution = points()
    health = 10 + modifier(constitution)
    %DndCharacter{strength: points(), dexterity: points(), constitution: constitution,
                  intelligence: points(), wisdom: points(), charisma: points(), hitpoints: health}
  end

  defp points do
    {min, sum } =
      Enum.reduce(1..3, {6,6}, fn _x, {min, acc} ->
        num = Enum.random(1..6)
        min = if num < min, do: num, else: min
        {min, acc+num}
      end)
    sum - min
  end
end
