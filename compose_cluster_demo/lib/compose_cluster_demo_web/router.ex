defmodule ComposeClusterDemoWeb.Router do
  use Phoenix.Router, helpers: false

  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ComposeClusterDemoWeb do
    pipe_through :api

    get("/", NodeListController, :list_nodes)
  end
end
