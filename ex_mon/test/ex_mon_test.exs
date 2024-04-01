defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game, Player}
  doctest ExMon

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Pikachu"
      }

      assert expected_response == ExMon.create_player("Pikachu", :chute, :soco, :cura)
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("soco", "cura", "chute", "Pikachu")

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has started!"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup %{} do
      player = Player.build(:soco, :cura, :chute, "Pikachu")

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The player attacked the computer"
      assert messages =~ "It's computer's turn"
      assert messages =~ "It's player's turn"
      assert messages =~ "status: :continue"


      capture_io(fn ->
        ExMon.make_move(:heal)
      end) =~ "healed itself"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
      assert messages =~ "status: :started"
    end

    test "when the game is already over" do
      info = Game.info()

      info
      |> Map.put(:player, %{info.player | life: 0})
      |> Game.update()

      messages =
        capture_io(fn ->
          ExMon.make_move(:soco)
        end)

      assert messages =~ "The game is over!"
      assert messages =~ "status: :game_over"
    end
  end
end
