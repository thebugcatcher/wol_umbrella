use Mix.Config

# Configure your database
config :wol, Wol.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("ECTO_PGSQL_USER"),
  password: System.get_env("ECTO_PGSQL_PASSWORD"),
  database: "wol_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
