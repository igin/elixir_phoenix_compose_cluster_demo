defmodule ComposeClusterDemo.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {DNSCluster, query: Application.get_env(:compose_cluster_demo, :dns_cluster_query)},
      ComposeClusterDemoWeb.Endpoint,
    ]

    opts = [strategy: :one_for_one, name: ComposeClusterDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    ComposeClusterDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
