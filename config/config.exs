# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ad_stock,
  ecto_repos: [AdStock.Repo]

# Configures the endpoint
config :ad_stock, AdStock.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/qvPutRAtRIHf/0+8N/UdolVDe7nEBlh8Z6BVcJ1iu9hYLevZZq1HdnUskZc9rKv",
  render_errors: [view: AdStock.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AdStock.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
