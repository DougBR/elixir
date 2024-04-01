defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  describe "build/1" do
    test "when a valid file is provided, returns the converted list" do
      expected_response =
        {:ok,
         [
           1,
           2,
           "Fizz",
           4,
           "Buzz",
           "Fizz",
           7,
           8,
           "Buzz",
           "FizzBuzz",
           "Buzz",
           "FizzBuzz",
           "Buzz",
           "FizzBuzz",
           "Buzz"
         ]}

      assert FizzBuzz.build("numbers.txt") == expected_response
    end

    test "when an invalid file is provided, returns an error message" do
      assert FizzBuzz.build("invalid.txt") == {:error, "Error reading the file: enoent"}
    end
  end
end
