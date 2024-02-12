# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :vidash_live_server,
  ecto_repos: [VidashLiveServer.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :vidash_live_server, VidashLiveServerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: VidashLiveServerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: VidashLiveServer.PubSub,
  live_view: [signing_salt: "6uSrsEHE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Auth
config :vidash_live_server, VidashLiveServerWeb.Auth.Guardian,
  issuer: "vidash_live_server",
  secret_key: System.get_env("VIDASH_AUTH_SECRET")

# Configures Cors
config :cors_plug,
  origins: "*",
  allow_headers: ["authorization", "content-type"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config AWS/S3
config :ex_aws,
  access_key_id: System.get_env("VIDASH_AWS_ACCESS_KEY"),
  secret_access_key: System.get_env("VIDASH_BUCKET_SECRET"),
  region: "eu-north-1"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
