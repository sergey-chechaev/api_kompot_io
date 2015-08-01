defmodule ApiKompot.Router do
  use ApiKompot.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ApiKompot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

  end



  # Other scopes may use custom stacks.
  scope "/", ApiKompot do
    pipe_through :api
    scope "/v1", V1, as: :v1 do
       resources "/metrics", MetricController
    end
  end
end
