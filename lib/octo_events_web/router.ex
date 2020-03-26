defmodule OctoEventsWeb.Router do
  use OctoEventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_api do
    plug :accepts, ["json"]
    plug BasicAuth, use_config: {:octo_events, :authentication}
  end

  scope "/api/v1", OctoEventsWeb do
    pipe_through :api

    resources("/events", EventController, only: [:create])
  end

  scope "/api/v1", OctoEventsWeb do
    pipe_through :admin_api

    resources("/issues/:number/events", IssueEventController, only: [:index])
  end
end
