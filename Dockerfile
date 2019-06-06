# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN apt-get update
RUN apt-get install curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash && apt-get install nodejs && node -v


# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force

# Compile the project
RUN mix do compile

RUN cd assets && npm install
EXPOSE 4000
CMD mix phx.server
