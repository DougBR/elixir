defmodule ExMon.Game.Actions.Heal do
  alias ExMon.Game
  alias ExMon.Game.Status

  @move_heal_power 18..25
  def heal(player) do
    heal_points = Enum.random(@move_heal_power)

    player
    |> Game.fetch_player()
    |> Map.get(:life)
    |> calculate_total_life(heal_points)
    |> update_life(player)
  end

  defp calculate_total_life(life, heal_points) when life + heal_points > 100, do: 100
  defp calculate_total_life(life, heal_points), do: life + heal_points

  defp update_life(life, player) do
    player
    |> Game.fetch_player()
    |> Map.put(:life, life)
    |> update_game(player, life)
  end

  defp update_game(player_data, player, life) do
    Game.info()
    |> Map.put(player, player_data)
    |> Game.update()

    Status.print_move_message(player, :heal, life)
  end
end
