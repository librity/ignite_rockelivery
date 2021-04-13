use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rockelivery, Rockelivery.Repo,
  username: "postgres",
  password: "postgres",
  database: "rockelivery_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rockelivery, RockeliveryWeb.Endpoint,
  http: [port: 4002],
  server: false

# Custom

config :rockelivery, Rockelivery.Users.Create, via_cep_adapter: ViaCEP.ClientMock
config :rockelivery, Rockelivery.Users.Update, via_cep_adapter: ViaCEP.ClientMock

if System.get_env("GITHUB_ACTIONS") do
  config :rockelivery, Rockelivery.Repo,
    username: "postgres",
    password: "postgres"
end

# Print only warnings and errors during test
config :logger, level: :warn
