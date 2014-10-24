defmodule CitpWebsocket.Router do
  use Phoenix.Router

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    # get "/", CitpWebsocket.PageController, :index
    get "/", CitpWebsocket.CitpController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api" do
  #   pipe_through :api
  # end
end
