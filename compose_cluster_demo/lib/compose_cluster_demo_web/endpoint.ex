defmodule ComposeClusterDemoWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :compose_cluster_demo

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug ComposeClusterDemoWeb.Router
end
