# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wol_web,
  namespace: WolWeb,
  ecto_repos: [Wol.Repo]

# Configures the endpoint
config :wol_web, WolWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D9xJuRQwNzVV5otVuBhpo1RyKzrLu5WwGxs+pyCf6q6FMe6tjL7g7c3rwDP9C8CA",
  render_errors: [view: WolWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WolWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :wol_web, :generators,
  context_app: :wol

config :rummage_ecto, Rummage.Ecto,
  default_repo: Wol.Repo,
  default_per_page: 5

config :wol_web, http_basic_config: [
  username: {:system, "WOL_BASIC_AUTH_USERNAME"},
  password: {:system, "WOL_BASIC_AUTH_PASSWORD"},
  realm: "wol"
]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
