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
    pipe_through :browser
    get "/", CoinsController, :index
  end

  scope "api/v1/transfer", ConversionApiWeb do
    pipe_through :api
    get "/", AccountController, :index
    get "/from/:from/to/:to/:value", AccountController, :transfer
  end
end
