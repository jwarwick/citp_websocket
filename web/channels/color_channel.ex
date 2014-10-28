defmodule CitpWebsocket.ColorChannel do
  use Phoenix.Channel

  @topic "data_topic"
  @channel "channel"

  def join(socket, @topic, _message) do
    reply(socket, "join", %{content: "joined #{@topic} successfully"})
    {:ok, socket}
  end

  def join(socket, _no, _message) do
    reply(socket, "error", %{reason: "failed to join #{@topic}"})
    {:error, socket, :unauthorized}
  end 

  def send_color_data(data) when is_list(data) do
    Phoenix.Channel.broadcast(@channel, @topic, "new:data", %{data: data})
  end
end
