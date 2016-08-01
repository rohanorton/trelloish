# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trelloish,
  ecto_repos: [Trelloish.Repo]

# Configures the endpoint
config :trelloish, Trelloish.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WbbdFYvBaN+lDRrVPD4311pTzUlCrIfpRyn8bZk+XuQmcOjBfDiwGRigvdxInxGO",
  render_errors: [view: Trelloish.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Trelloish.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
