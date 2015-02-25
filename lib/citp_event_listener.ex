defmodule CitpEventListener do
  use GenEvent
  require Logger

  @default_skip 3

  defmodule State do
    # skip is the number of incoming packets to skip before
    # forwarding a packet to the websocket
    defstruct skip: 3, current: 0
  end

  def start() do
    pid = {CitpEventListener, make_ref}
    :ok = ExCitp.Events.subscribe(pid)
    {:ok, pid}
  end

  def stop_logger(pid) do
    ExCitp.Events.unsubscribe(pid)
  end

  def init(_args) do
    skip = Application.get_env(:citp_event_listener, :skip_packets, @default_skip)
    Logger.info "#{__MODULE__}: skip value = #{inspect skip}"
    {:ok, %State{skip: skip}}
  end

  def handle_event({:citp_event, {:peer_name, data}}, state) do
    CitpWebsocket.ColorChannel.send_peer_name(data.name)
    {:ok, state}
  end
  def handle_event({:citp_event, {:channel_block, data}}, state = %State{current: curr}) when curr <= 0 do
    CitpWebsocket.ColorChannel.send_color_data(data.universe_index, data.levels)
    {:ok, %State{ state | current: state.skip}}
  end
  def handle_event({:citp_event, {:channel_block, _data}}, state = %State{current: curr}) do
    {:ok, %State{ state | current: curr - 1}}
  end
  def handle_event(event, state) do
    Logger.warn "Unknown event: #{inspect event}"
    Logger.warn "Unknown state: #{inspect state}"
    {:ok, state}
  end
end
