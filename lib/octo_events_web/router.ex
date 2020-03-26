defmodule OctoEventsWeb.Router do
  use OctoEventsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", OctoEventsWeb do
    pipe_through :api

    resources("/events", EventController, only: [:create])
  end

  scope "/api/v1", OctoEventsWeb do
    pipe_through :api

    resources("/issues/:number/events", IssueEventController, only: [:index])
  end
end
