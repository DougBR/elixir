defmodule ExMon.PlayerTest do
  use ExUnit.Case
  doctest ExMon.Player

  test "when valid names are provided, create a player" do
    assert ExMon.Player.build(:soco, :cura, :chute, "Pikachu") ==
             %ExMon.Player{
               life: 100,
               moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
               name: "Pikachu"
             }
  end
end
