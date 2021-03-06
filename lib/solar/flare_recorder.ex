defmodule Solar.FlareRecorder do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__,[])
  end

  def record(pid, flare) do
    GenServer.cast(pid, {:new, flare})
  end

  def current(pid) do
    GenServer.call(pid, :load)
  end

  def handle_call(:load, _sender, state) do
    {:reply, get_flares, []}
  end

  def handle_cast({:new, flare}, state) do
    add_flare(flare)
    {:noreply, []}
  end

  defp add_flare(flare) do
    """
    insert into solar_flares(classification, scale, date)
    values($1, $2, now()) RETURNING *;
    """
    |> execute([flare.classification, flare.scale])
  end

  defp connect do
    Postgrex.Connection.start_link(hostname: "localhost", database: "redfour")
  end

  defp execute(sql, params \\ []) do
    case connect do
      {:ok, pid} ->
        result = Postgrex.Connection.query!(pid, sql, params) |> transform_result
        Postgrex.Connection.stop(pid)
      {:error, err} ->
        {:error, err.message}
    end
  end

  defp get_flares do
    """
    select * from solar_flares
    """
    |> execute
  end

  defp transform_result(result) do
    atomized = for col <- result.columns, do: String.to_atom(col)
    for row <- result.rows, do: List.zip([atomized, row]) |> Enum.into(%{})
  end
end
