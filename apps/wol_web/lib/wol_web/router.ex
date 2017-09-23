defmodule WolWeb.Router do
  use WolWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WolWeb do
    pipe_through :browser # Use the default browser stack

    resources "/people", PersonController
    resources "/pair_iterations", PairIterationController
    get "/", PageController, :index
    get "/about", PageController, :about
  end

  # Other scopes may use custom stacks.
  # scope "/api", WolWeb do
  #   pipe_through :api
  # end
end
