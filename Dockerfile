# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

RUN rm -rf /app/_build

RUN mix local.rebar --force

# Install hex package manager
RUN mix local.hex --force

# Compile the project
RUN mix do compile

RUN chmod 777 /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]