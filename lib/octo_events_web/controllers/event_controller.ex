defmodule OctoEventsWeb.EventController do
  use OctoEventsWeb, :controller

  alias OctoEvents.CreateEvent

  action_fallback OctoEventsWeb.ApiFallbackController

  def create(conn, %{"payload" => payload}) do
    event_type = get_req_header(conn, "x-github-event")
    decoded_payload = Jason.decode!(payload)

    with {:ok, event} <- CreateEvent.run(event_type, decoded_payload) do
      conn
      |> put_status(:created)
      |> render("event.json", %{event: event})
    end
  end
end
