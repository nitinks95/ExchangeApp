# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :exchange,
  namespace: Exchange.Console

config :exchange_web,
  namespace: Exchange.ConsoleWeb,
  generators: [context_app: :exchange]

# Configures the endpoint
config :exchange_web, Exchange.ConsoleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U4PCZqQfcl0B+48Z1p+yU/x2hFyRuG7VP2rOHVcIkkH9eYVuLyVh3GxScN+DR8EL",
  render_errors: [view: Exchange.ConsoleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Exchange.Console.PubSub,
  live_view: [signing_salt: "QgRhANdk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
