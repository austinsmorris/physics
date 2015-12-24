defmodule SolarTests do
  use ExUnit.Case
  use Timex

  import Solar.Flare

  setup do
    flares = [
      %Solar.Flare{classification: :X, scale: 99, date: Date.from({1859, 8, 29})},
      %Solar.Flare{classification: :M, scale: 5.8, date: Date.from({2015, 1, 12})},
      %Solar.Flare{classification: :M, scale: 1.2, date: Date.from({2015, 2, 9})},
      %Solar.Flare{classification: :C, scale: 3.2, date: Date.from({2015, 4, 18})},
      %Solar.Flare{classification: :M, scale: 83.6, date: Date.from({2015, 6, 23})},
      %Solar.Flare{classification: :C, scale: 2.5, date: Date.from({2015, 7, 4})},
      %Solar.Flare{classification: :X, scale: 72, date: Date.from({2012, 7, 23})},
      %Solar.Flare{classification: :X, scale: 45, date: Date.from({2003, 11, 4})},
    ]
    {:ok, data: flares}
  end

  test "A Solar Flare is a Map with a special key" do
    assert %Solar.Flare{}.__struct__ == Solar.Flare
  end
  
  test "We have 8 solar flares", %{data: flares} do
    assert length(flares) == 8
  end

  test "Go inside!", %{data: flares} do
    bad_flares = no_eva(flares)
    assert length(bad_flares) == 3
  end

  test "Ouch", %{data: flares} do
    deadliest_flare = deadliest(flares)
    assert deadliest_flare == 99_000
  end

  test "A list of flares", %{data: flares} do
    result = flare_list(flares)
    assert result == [
      %{power: 99000, is_deadly: true},
      %{power: 58.0, is_deadly: false},
      %{power: 12.0, is_deadly: false},
      %{power: 3.2, is_deadly: false},
      %{power: 836.0, is_deadly: false},
      %{power: 2.5, is_deadly: false},
      %{power: 72000, is_deadly: true},
      %{power: 45000, is_deadly: true}
   ]
  end

  test "power for X" do
    assert power(%{classification: :X, scale: 10}) == 10_000
  end

  test "power for M" do
    assert power(%{classification: :M, scale: 10}) == 100
  end

  test "power for C" do
    assert power(%{classification: :C, scale: 10}) == 10
  end
end
