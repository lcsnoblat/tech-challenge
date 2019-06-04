defmodule ConversionApiWeb.Router do
  use ConversionApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ConversionApiWeb do
    pipe_through :api
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/api/v1/currency", ConversionApiWeb do
    pipe_through :api
    get "/", CoinsController, :index
    post "/convert", CoinsController, :convert
    post "/create", CoinsController, :create
    get "/:id", CoinsController, :show
  end

  scope "api/v1/account", ConversionApiWeb do
    pipe_through :api
    get "/", AccountController, :index
    post "/transfer", AccountController, :transfer
    post "/create", AccountController, :create
    get "/:id", AccountController, :show
  end
end
