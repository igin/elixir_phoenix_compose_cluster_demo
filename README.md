## Demo of running multiple Elixir & Phoenix nodes in a local cluster using docker compose and dns_cluster

This is a minimal demo showing the required pieces to start a local cluster inside docker-compose. To start the demo run the following command in the root directory of this repo.

```
docker-compose up
```
Once the application has started you should be able to access the following endpoints on the different nodes to see that they are connected:

```
http://localhost:4000/        # Node 1 
http://localhost:4001/        # Node 2
http://localhost:4002/        # Node 3
```

The endpoints return a json of the following form:

```
{
    "me":"app@10.0.0.11",
    "others":[
        "app@10.0.0.13",
        "app@10.0.0.12"
    ]
}
```


### How does this work?

The default `mix phx.new` projects ship with a library called [dns_cluster](https://github.com/phoenixframework/dns_cluster). It is a simple library that polls DNS for a specified query and uses the returned IP addresses to discover nodes of the same application. In this demo we provide the DNS query `app.internal` to the DNS cluster of each node. In the docker-compose file we then mark all nodes to be aliased under `app.internal`. Through the magic of docker compose this means that the internal docker DNS server will respond to queries of `app.internal` with the ip addresses of all nodes. You can test that by logging into one of the nodes and querying the dns server with `dig`.

```
> dig app.internal
...
;; ANSWER SECTION:
app.internal.		600	IN	A	10.0.0.11
app.internal.		600	IN	A	10.0.0.13
app.internal.		600	IN	A	10.0.0.12
```

Nice. The dns_cluster library then uses these ip address and tries to connect to nodes that have the same basename as the current node and are located at that ip address (see the [connect_new_nodes](https://github.com/phoenixframework/dns_cluster/blob/0152de91718245dcf720344bc5d79cc80830ecbb/lib/dns_cluster.ex#L116C8-L116C25) function).

>[!Note]
>As docker just directly returns the IP addresses in the DNS queries, dns_cluster will always try to connect using the IP address. Therefore the long node name needs to use the IP address instead of the service name. By default services are assigned random IPs within the network. To make sure the node knows its IP address and names itself by that IP address we can give the services static IP addresses and use those to name the nodes.

### Why does this not use the `RELEASE_NODE` env variable?

To use `RELEASE_NODE` and `RELEASE_COOKIE` you need to create a release of your phoenix application. As I wanted to have the most simple demo I wanted to avoid the loop through releases. I therefore pass the node name and cookie directly to elixir in the `CMD` of the dockerfile.

### Where is all the other phoenix stuff?

When trying to understand how this clustering works I was confused with a lot of the available information as they were using complete phoenix applications with a lot of things that are not relevant for understanding the clustering. I therefore wanted this demo to be as minimal as possible. Actually you could also remove the phoenix endpoint alltogether. Its only used here to have a simple way to return a response to the browser.