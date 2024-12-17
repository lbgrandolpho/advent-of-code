defmodule AdventOfCode.Year2024.Day1 do
  def day1_1 do
    [list1, list2] =
      File.stream!("./lib/2024/day01/input.txt")
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

  def day1_2 do
    [list1, list2] =
      File.stream!("./lib/2024/day01/input.txt")
      |> Enum.reduce([[], []], fn line, [acc1, acc2] ->
        [col1, col2] =
          line
          |> String.split()

        [acc1 ++ [String.to_integer(col1)], acc2 ++ [String.to_integer(col2)]]
      end)

    count_list1 = Enum.frequencies(list1)
    count_list2 = Enum.frequencies(list2)

    result =
      list1
      |> Enum.uniq()
      |> Enum.map(&(&1 * Map.get(count_list1, &1, 0) * Map.get(count_list2, &1, 0)))
      |> Enum.sum()

    IO.puts("Resultado: #{result}")
  end
end
