defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "start the game with player and computer" do
      player = Player.build("soco", "cura", "chute", "Pikachu")
      computer = Player.build("soco", "cura", "chute", "Robotinik")

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build(:soco, :cura, :chute, "Pikachu")
      computer = Player.build(:soco, :cura, :chute, "Robotinik")
      Game.start(computer, player)

      expected_response = %{
        status: :started,
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura},
          name: "Pikachu"
        },
        turn: :player,
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura},
          name: "Robotinik"
        }
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build(:soco, :cura, :chute, "Pikachu")
      computer = Player.build(:soco, :cura, :chute, "Robotinik")
      Game.start(computer, player)

      new_state = %{
        status: :started,
        player: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura},
          name: "Pikachu"
        },
        turn: :player,
        computer: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_rnd: :chute, move_heal: :cura},
          name: "Robotinik"
        }
      }

      Game.update(new_state)

      assert %{new_state | turn: :computer, status: :continue} == Game.info()
    end
  end
end
