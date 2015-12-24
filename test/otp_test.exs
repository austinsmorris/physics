defmodule OTPTest do
  use ExUnit.Case

  test "A Simple service" do
    {:ok, pid} = Solar.FlareRecorder.start_link()
    Solar.FlareRecorder.record(pid, %{classification: "M", scale: 22})
    Solar.FlareRecorder.record(pid, %{classification: "X", scale: 33})
    res = Solar.FlareRecorder.current(pid)
    # IO.inspect res
  end

  test "Blow up PostgreSQL" do
    {:ok, pid} = Solar.FlareRecorder.start_link
    result = Enum.map 1..10000, fn(n) ->
      Solar.FlareRecorder.record(pid, %{classification: "X", scale: 33})
    end

    IO.inspect result
    :timer.sleep(10000)
  end
end
