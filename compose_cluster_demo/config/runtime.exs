import Config

config :compose_cluster_demo, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")
