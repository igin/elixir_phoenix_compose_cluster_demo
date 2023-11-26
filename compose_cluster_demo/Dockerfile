ARG VARIANT=latest
FROM elixir:${VARIANT}

COPY . .

RUN mix deps.get

EXPOSE 4000

CMD echo "Starting Node ${NODE_NAME}" && elixir --name ${NODE_NAME} --cookie ${NODE_COOKIE} -S mix phx.server
