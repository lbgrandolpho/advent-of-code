defmodule AdventOfCode.Year2024.Day1 do
  def day1() do
    [list1, list2] =
      File.stream!("/home/lucas-cross/advent-of-code/advent_of_code/lib/2024/day1/input.txt")
      |> Enum.reduce([[], []], fn line, [acc1, acc2] ->
        [col1, col2] =
          line
          |> String.trim()
          |> String.split(~r/\s+/)

        [acc1 ++ [String.to_integer(col1)], acc2 ++ [String.to_integer(col2)]]
      end)
      |> Enum.map(&Enum.sort(&1))

    result =
      Enum.zip(list1, list2)
      |> Enum.map(fn {x, y} -> abs(x - y) end)
      |> Enum.reduce(fn distance, acc -> acc + distance end)

    IO.puts("Resultado: #{result}")
  end
end
