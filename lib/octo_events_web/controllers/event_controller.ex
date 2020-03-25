defmodule OctoEventsWeb.EventController do
  use OctoEventsWeb, :controller

  alias OctoEvents.CreateEvent

  def create(conn, %{"payload" => payload}) do
    event_type = get_req_header(conn, "http_x_github_event")

    case CreateEvent.run(event_type, payload) do
      {:ok, event} ->
        conn
        |> put_status(201)
        |> render("event.json", %{event: event})
      {:error, _} ->
        conn
        |> put_status(422)
        |> json(%{status: "unprocessable entity"})
      end
  end
end
