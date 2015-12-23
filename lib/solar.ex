defmodule Solar do
  def deadliest(flares) do
    (Enum.map flares, &(power(&1)))
      |> Enum.max
  end

  def no_eva(flares) do
    Enum.filter flares, &(power(&1) > 1000)
  end

  def power(%{classification: classification, scale: scale}), do: classification_multiplier(classification) * scale

  defp classification_multiplier(:X), do: 1000
  defp classification_multiplier(:M), do: 10
  defp classification_multiplier(:C), do: 1
end
