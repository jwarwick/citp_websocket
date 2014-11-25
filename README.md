# CitpWebsocket

Listen for CITP (http://www.citp-protocol.org/) visualizer data and retransmit the contents to a websocket.

## Installation

CitpWebsocket is built on Elixir (http://elixir-lang.org/) and uses the Phoenix web framework (https://github.com/phoenixframework/phoenix).

To install on a Mac using Homebrew (http://brew.sh/):
```
  % brew install elixir
  % git clone https://github.com/jwarwick/citp_websocket.git
  % cd citp_websocket
  % mix deps.get
  % mix phoenix.start
```

Then visit `localhost:4000` to see any streamed CITP data.
