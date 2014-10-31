defmodule CitpEventListener do
  use GenEvent
  require Logger

  def start() do
    pid = {CitpEventListener, make_ref}
    :ok = ExCitp.Events.subscribe(pid)
    {:ok, pid}
  end

  def stop_logger(pid) do
    ExCitp.Events.unsubscribe(pid)
  end

  def handle_event({:citp_event, {:peer_name, data}}, state) do
    CitpWebsocket.ColorChannel.send_peer_name(data.name)
    {:ok, state}
  end
  def handle_event({:citp_event, {:channel_block, data}}, state) do
    CitpWebsocket.ColorChannel.send_color_data(data.universe_index, data.levels)
    {:ok, state}
  end
  def handle_event(event, state) do
    Logger.warn "Unknown event: #{inspect event}"
    {:ok, state}
  end
end
