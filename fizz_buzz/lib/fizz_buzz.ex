defmodule FizzBuzz do
  @moduledoc """
  Documentation for `FizzBuzz`.
  """

  @doc """
  FizzBuzz.

  ## Examples

      iex> FizzBuzz.build("numbers.txt")
      {:ok, [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Buzz", "FizzBuzz", "Buzz", "FizzBuzz", "Buzz", "FizzBuzz", "Buzz"]}

  """

  def build(file_name) do
    File.read(file_name)
    |> handle_file_read
  end

  defp handle_file_read({:ok, result}) do
    result
    |> String.split(",")
    |> Enum.map(&convert_and_fizzbuzz/1)
    |> parse_return()
  end

  defp handle_file_read({:error, reason}), do: {:error, "Error reading the file: #{reason}"}

  defp convert_and_fizzbuzz(elem) do
    elem
    |> String.to_integer()
    |> fizz_buzz()
  end

  defp fizz_buzz(number) when rem(number, 15) == 0, do: "FizzBuzz"
  defp fizz_buzz(number) when rem(number, 3) == 0, do: "Fizz"
  defp fizz_buzz(number) when rem(number, 5) == 0, do: "Buzz"
  defp fizz_buzz(number), do: number

  defp parse_return(result), do: {:ok, result}

  def build1(file_name) do
    case File.read(file_name) do
      {:ok, result} -> result
      {:error, reason} -> reason
    end
  end
end
