defmodule CalcsTest do
  use ExUnit.Case
  doctest Calcs

  test "km_to_m even" do
    assert Calcs.km_to_m(5) == 5000
  end

  test "km_to_m decimal" do
    assert Calcs.km_to_m(1.234) == 1234
  end

  test "m_to_km even" do
    assert Calcs.m_to_km(5000) == 5
  end

  test "m_to_km decimal" do
    assert Calcs.m_to_km(1234) == 1.234
  end

  test "rounded_up_to_nearest_tenth down" do
    assert Calcs.rounded_up_to_nearest_tenth(11.30001) == 11.4
  end

  test "rounded_up_to_nearest_tenth up" do
    assert Calcs.rounded_up_to_nearest_tenth(11.36) == 11.4
  end

  test "rounded_up_to_nearest_tenth half" do
    assert Calcs.rounded_up_to_nearest_tenth(11.35) == 11.4
  end

  test "rounded_up_to_nearest_tenth zero" do
    assert Calcs.rounded_up_to_nearest_tenth(11.30) == 11.3
  end
end
