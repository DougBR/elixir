defmodule ExMon.GameTest.ActionsTest do
  use ExUnit.Case

  alias ExMon.Game
  alias ExMon.Player

  import ExUnit.CaptureIO

  describe "fetch_move/1" do
    setup do
      player = Player.build(:soco, :cura, :chute, "Pikachu")


      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when chute" do
      actual_response = Game.Actions.fetch_move(:chute)

      assert {:ok, :move_rnd} == actual_response
    end

    test "when soco" do
      actual_response = Game.Actions.fetch_move(:soco)

      assert {:ok, :move_avg} == actual_response
    end

    test "when the move is invalid" do
      actual_response = Game.Actions.fetch_move(:wrong_move)

      assert {:error, :wrong_move} == actual_response
    end
  end

  describe "heal/0" do
    setup do
      player = Player.build(:soco, :cura, :chute, "Pikachu")

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end
    test "heal when life is already full" do
      assert capture_io(fn ->
        Game.Actions.heal()
      end) == "\n=======The player healed itself to 100 life points!=======\n"
    end

    test "heal when life is low" do
      info = Game.info()

      info
      |> Map.put(:computer, %{info.computer | life: 10})
      |> Game.update()

      assert capture_io(fn ->
        Game.Actions.heal()
      end) =~ "The computer healed itself"
    end
  end

  describe "attack/1" do
    setup do
      player = Player.build(:soco, :cura, :chute, "Pikachu")

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end
    test "attack when game ongoing" do
      assert capture_io(fn ->
        Game.Actions.attack(:move_avg)
      end) =~ "attacked the"
    end

    test "attack when game over" do
      # info = Game.info()

      # info
      # |> Map.put(:computer, %{info.computer | life: 10})
      # |> Game.update()
      # assert capture_io(fn ->
      #   Game.Actions.attack(:move_avg)
      # end) =~ "The computer healed itself"
    end

    test "when damage exceeds life" do
      info = Game.info()

      info
      |> Map.put(:player, %{info.player | life: 5})
      |> Map.put(:computer, %{info.player | life: 5})
      |> Game.update()
      assert capture_io(fn ->
        Game.Actions.attack(:move_avg)
      end) =~ " attacked the"
    end
  end
end
