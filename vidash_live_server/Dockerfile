# Specify builder image
ARG ELIXIR_VERSION=1.16.0
ARG OTP_VERSION=26.2.1
ARG DEBIAN_VERSION=bullseye-20231009-slim
ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
FROM ${BUILDER_IMAGE} as builder

# Set the working directory in the builder stage
WORKDIR /app

# Copy mix files and fetch dependencies
COPY mix.exs mix.lock /app/
RUN mix deps.get

# Copy the rest of the application code
COPY . /app

# Compile the application
RUN mix compile

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

# Set the working directory for asset compilation
WORKDIR /app/assets
RUN npm install

# Set the working directory back to the app root
WORKDIR /app

# Get dependencies again (in case any assets require additional dependencies)
RUN mix deps.get

# Compile again (in case any assets require additional compilation)
RUN mix compile

# Expose port for Phoenix server
EXPOSE 4000

# Clean up unnecessary files
RUN mix clean

# Set up and migrate the database
RUN mix ecto.setup

# Create the digests
RUN mix phx.digest

# Start the Phoenix server in production mode
CMD mix phx.server
