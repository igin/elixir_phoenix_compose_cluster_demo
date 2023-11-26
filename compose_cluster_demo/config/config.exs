import Config

config :compose_cluster_demo, ComposeClusterDemoWeb.Endpoint,
  http: [ip: {0, 0, 0, 0}, port: 4000],
  url: [host: "0.0.0.0"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  watchers: []

config :phoenix, :json_library, Jason
