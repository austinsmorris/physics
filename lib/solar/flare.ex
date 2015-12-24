defmodule Solar.Flare do
  defstruct [
    classification: :M,
    scale: 0,
    power: 0,
    is_deadly: false,
    date: nil
  ]

  def deadliest(flares) do
    (Enum.map flares, &(power(&1)))
      |> Enum.max
  end

  def flare_list(flares) do
    for flare <- flares, power <-[power(flare)], is_deadly <- [power > 1000],
      do: %{power: power, is_deadly: is_deadly}
  end

  def load(flares) do
    for flare <- flares, do: flare |> calculate_power |> calculate_deadliness
  end

  def no_eva(flares), do: Enum.filter flares, &(power(&1) > 1000)

  def power(%{classification: classification, scale: scale}), do: classification_multiplier(classification) * scale

  def total_flare_power(flares), do: total_flare_power(flares, 0)
  def total_flare_power([head | tail], total), do: total_flare_power(tail, power(head) + total)
  def total_flare_power([], total), do: total

  defp calculate_deadliness(flare), do: %{flare | is_deadly: flare.power > 1000}

  defp calculate_power(flare), do: %{flare | power: power(flare)}

  defp classification_multiplier(:X), do: 1000
  defp classification_multiplier(:M), do: 10
  defp classification_multiplier(:C), do: 1
end
