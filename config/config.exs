# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rockelivery,
  ecto_repos: [Rockelivery.Repo]

# Custom

config :rockelivery, Rockelivery.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :rockelivery, Rockelivery.Users.Create, via_cep_adapter: ViaCEP.Client
config :rockelivery, Rockelivery.Users.Update, via_cep_adapter: ViaCEP.Client

config :rockelivery, RockeliveryWeb.Auth.Guardian,
  issuer: "rockelivery",
  secret_key: "UC6kkjcR3xoz++l+jm6Wdv9F+HzvflRQmTe644z6jdSr0UfA2LVOD5JvCOuwPUT6"

# Configures the endpoint
config :rockelivery, RockeliveryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6xd8GfkXeaSRqsD8cruDs2wtUZD0pG6U2UNUA6h0SQ2dT7eIpmsFy1F7ogbpFDC1",
  render_errors: [view: RockeliveryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rockelivery.PubSub,
  live_view: [signing_salt: "UxP0CcSW"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
