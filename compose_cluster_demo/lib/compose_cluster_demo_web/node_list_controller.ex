defmodule ComposeClusterDemoWeb.NodeListController do
  use Phoenix.Controller, formats: [:json]

  def list_nodes(conn, _params) do
    json(conn, %{
      me: Node.self,
      others: Node.list
    })
  end
end
