defmodule Calcs do
  def cubed(val) do
    val * val * val
  end

  def km_to_m(val) do
    val * 1000
  end

  def m_to_km(val) do
    val / 1000
  end

  def rounded_up_to_nearest_tenth(val) do
    Float.ceil(val, 1)
  end

  def seconds_to_hours(val) do
    val / 3600
  end

  def square_root(val) do
    :math.sqrt val
  end

  def squared(val) do
    val * val
  end
end
