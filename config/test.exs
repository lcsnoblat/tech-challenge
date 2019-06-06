use Mix.Config

# Configure your database
config :conversion_api, ConversionApi.Repo,
  username: "kszkuyzz",
  password: "sBcYxr-eBDmJoFuLEwKNm0K_w03hWyKe",
  database: "kszkuyzz",
  hostname: "raja.db.elephantsql.com",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :conversion_api, ConversionApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
