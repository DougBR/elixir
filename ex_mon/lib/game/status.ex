defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message(%{status: :started} = info) do
    IO.puts("\n=======The game has started!=======")
    IO.inspect(info)
    IO.puts("------------------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\n=======It's #{player}'s turn!=======")
    IO.inspect(info)
    IO.puts("------------------")
  end

  def print_round_message(%{status: :game_over} = info) do
    IO.puts("\n=======The game is over!=======")
    IO.inspect(info)
    IO.puts("------------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\n=======Invalid move: #{move} ========")
    IO.puts("Choose another move: ")
    IO.inspect(Game.info())
    IO.puts("------------------")
  end

  def print_move_message(:computer, :attack, damage),
    do:
      IO.puts("\n=======The player attacked the computer with #{damage} points of damage!=======")

  def print_move_message(:player, :attack, damage),
    do:
      IO.puts("\n=======The computer attacked the player with #{damage} points of damage!=======")

  def print_move_message(player, :heal, life),
    do: IO.puts("\n=======The #{player} healed itself to #{life} life points!=======")
end
