# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :natureba,
  ecto_repos: [Natureba.Repo]

# Configures the endpoint
config :natureba, NaturebaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RClQWPhcWIjAT6eycE23TO0Gt15Vfb13CUGKNLDfCXpG1mNJhRWFk0XC+bFHF1bD",
  render_errors: [view: NaturebaWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Natureba.PubSub,
  live_view: [signing_salt: "TDIA8RCf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
