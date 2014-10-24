# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the router
config :phoenix, CitpWebsocket.Router,
  url: [host: "localhost"],
  http: [port: System.get_env("PORT")],
  secret_key_base: "zPH31vLCJBpLouvZyIYJML0hOZYYieDS9jePYtCK2UdU1LMR8hlS5/7j+yCcvh4hSltQgn+3phdhYLLBa9vMmw==",
  catch_errors: true,
  debug_errors: false,
  error_controller: CitpWebsocket.PageController

# Session configuration
config :phoenix, CitpWebsocket.Router,
  session: [store: :cookie,
            key: "_citp_websocket_key"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
