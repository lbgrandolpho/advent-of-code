defmodule AdventOfCode.Year2024.Day2 do
  def day2_1 do
    reports =
      File.stream!("./lib/2024/day02/input.txt")
      |> Enum.map(fn line ->
        line
        |> String.split()
        |> Enum.map(&String.to_integer(&1))
      end)

    counter =
      reports
      |> Enum.reduce(0, fn report, acc ->
        if safe?(report), do: acc + 1, else: acc
      end)

    IO.puts("Result: #{counter}")
  end

  defp safe?(report), do: valid_diff(report) && valid_trend(report)

  defp valid_diff([level1, level2 | rest]) when abs(level1 - level2) <= 3,
    do: valid_diff([level2 | rest])

  defp valid_diff([_]), do: true
  defp valid_diff(_), do: false

  defp valid_trend(report) do
    case trend(report) do
      :increasing -> check_increasing(report)
      :decreasing -> check_decreasing(report)
      _ -> false
    end
  end

  defp trend([level1, level2 | _rest]) when level1 < level2, do: :increasing
  defp trend([level1, level2 | _rest]) when level1 > level2, do: :decreasing
  defp trend(_), do: :none

  defp check_increasing([level1, level2 | rest]) when level1 < level2,
    do: check_increasing([level2 | rest])

  defp check_increasing([_]), do: true
  defp check_increasing(_), do: false

  defp check_decreasing([level1, level2 | rest]) when level1 > level2,
    do: check_decreasing([level2 | rest])

  defp check_decreasing([_]), do: true
  defp check_decreasing(_), do: false

  def day2_2 do
    reports =
      File.stream!("./lib/2024/day02/input.txt")
      |> Enum.map(fn line ->
        line
        |> String.trim()
        |> String.split()
        |> Enum.map(&String.to_integer(&1))
      end)

    counter =
      reports
      |> Enum.reduce(0, fn report, acc ->
        if safe_with_problem_dampener?(report), do: acc + 1, else: acc
      end)

    IO.puts("Result: #{counter}")
  end

  defp safe_with_problem_dampener?(report) do
    if valid_diff(report) && valid_trend(report) do
      true
    else
      Enum.reduce_while(0..(length(report) - 1), false, fn level, _acc ->
        new_report = List.delete_at(report, level)

        if valid_diff(new_report) && valid_trend(new_report),
          do: {:halt, true},
          else: {:cont, false}
      end)
    end
  end
end
