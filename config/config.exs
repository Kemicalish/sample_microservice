# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :user_manager,
  ecto_repos: [UserManager.Repo]

# Configures the endpoint
config :user_manager, UserManager.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9XpCu6zKm8H0ITgLpcZv6QYbTVdzyA90nXvraj5Csq29NKwC80pQodVL04Yh6QmG",
  render_errors: [view: UserManager.ErrorView, accepts: ~w(json)],
  pubsub: [name: UserManager.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Dayron
config :user_manager, UserManager.KongAdminRepo,
  adapter: UserManager.KongAdminAdapter, 
  url: "http://admin-gateway.pow.tf"
config :user_manager, UserManager.KongRepo,
  adapter: UserManager.KongAdminAdapter,
  url: "https://gateway.pow.tf"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
