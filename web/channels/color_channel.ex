defmodule CitpWebsocket.ColorChannel do
  use Phoenix.Channel

  def join(socket, "topic", _message) do
    reply(socket, "join", %{content: "from elixir, joined 'topic' successfully"})
    {:ok, socket}
  end

  def join(socket, _no, _message) do
    reply(socket, "error", %{reason: "from elixir, failed to join topic"})
    {:error, socket, :unauthorized}
  end 
end
