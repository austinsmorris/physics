defmodule RocketryTest do
  use ExUnit.Case
  doctest Physics.Rocketry

  test "escape_velocity earth" do
    assert Physics.Rocketry.escape_velocity(:earth) == 11.2
  end

  test "escape_velocity mars" do
    assert Physics.Rocketry.escape_velocity(:mars) == 5.1
  end

  test "escape_velocity moon" do
    assert Physics.Rocketry.escape_velocity(:moon) == 2.4
  end

  test "escape_velocity planet" do
    assert Physics.Rocketry.escape_velocity(%{mass: 1, radius: 1}) ==
      :math.sqrt(2 * 6.67e-11) |> Calcs.m_to_km |> Calcs.rounded_up_to_nearest_tenth
  end
end
