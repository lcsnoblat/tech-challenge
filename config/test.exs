use Mix.Config

# Configure your database
config :conversion_api, ConversionApi.Repo,
  username: "rrztkexe",
  password: "j1ftYmxorHRcChhJH7cKgRanAHhPDr2q",
  database: "rrztkexe",
  hostname: "isilo.db.elephantsql.com",
  pool_size: 5,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conversion_api, ConversionApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
