defmodule ComposeClusterDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :compose_cluster_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: ["lib"],
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ComposeClusterDemo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.7.10"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:plug_cowboy, "~> 2.5"}
    ]
  end
end
