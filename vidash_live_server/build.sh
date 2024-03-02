#!/usr/bin/env bash
# exit on error
set -o errexit

# Initial setup
mix deps.get --only prod
MIX_ENV=prod mix compile

# Compile assets
# npm install --prefix ./assets
# npm run deploy --prefix ./assets
# mix phx.digest

# PHX_SERVER=true

# Build the release and overwrite the existing release directory
MIX_ENV=prod mix release --overwrite

MIX_ENV=prod mix ecto.create
MIX_ENV=prod mix ecto.migrate
# Migrate
_build/prod/rel/vidash_live_server/bin/vidash_live_server eval "VidashLiveServer.Release.migrate"
