import Config

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
config :vidash_live_server, VidashLiveServerWeb.Endpoint,
    force_ssl: [rewrite_on: [:x_forwarded_proto]],
    url: [host: System.get_env("RENDER_EXTERNAL_HOSTNAME") || "localhost", port: 80, scheme: "https"],
    cache_static_manifest: "priv/static/cache_manifest.json"
