defmodule Physics do
  def bomb do
    {:ok, pid} = Solar.FlareRecorder.start_link
    result = Enum.map 1..10_000, fn(n) ->
      Solar.FlareRecorder.record(pid, %{classification: "X", scale: 33})
    end
  end
end
