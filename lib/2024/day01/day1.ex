defmodule AdventOfCode.Year2024.Day1 do
  def day1 do
    [list1, list2] =
      File.stream!("./lib/2024/day1/input.txt")
      |> Enum.reduce([[], []], fn line, [acc1, acc2] ->
        [col1, col2] =
          line
          |> String.split()

        [acc1 ++ [String.to_integer(col1)], acc2 ++ [String.to_integer(col2)]]
      end)
      |> Enum.map(&Enum.sort(&1))

    result =
      Enum.zip(list1, list2)
      |> Enum.map(fn {x, y} -> abs(x - y) end)
      |> Enum.sum()

    IO.puts("Resultado: #{result}")
  end
end
