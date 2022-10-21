import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :auth0_backend, Auth0Backend.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "auth0_backend_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :auth0_backend, Auth0BackendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "LnWiSEpvcV9OVA/DAYykoftFdOHRb4jIIXPOOZ1ZV+dIKm1hDBhaEnpmbY1zN5H+",
  server: false

# In test we don't send emails.
config :auth0_backend, Auth0Backend.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
