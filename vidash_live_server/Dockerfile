# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian
# instead of Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20231009-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.16.0-erlang-26.2.1-debian-bullseye-20231009-slim
#
ARG ELIXIR_VERSION=1.16.0
ARG OTP_VERSION=26.2.1
ARG DEBIAN_VERSION=bullseye-20231009-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# create app folder
RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force \
&& mix local.rebar --force
RUN mix archive.install hex phx_new --force

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

WORKDIR /app

RUN cd assets && npm install

RUN cd ../

RUN mix deps.get

RUN mix compile

EXPOSE 4000

RUN mix clean
RUN mix ecto.setup

# create the digests
RUN mix phx.digest

# run phoenix in production on PORT 4000
CMD mix phx.server

# Only copy the final release from the build stage
# COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/vidash_live_server ./

# USER nobody

# # If using an environment that doesn't automatically reap zombie processes, it is
# # advised to add an init process such as tini via `apt-get install`
# # above and adding an entrypoint. See https://github.com/krallin/tini for details
# # ENTRYPOINT ["/tini", "--"]

# CMD ["/app/bin/server"]
