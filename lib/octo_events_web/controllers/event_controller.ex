defmodule OctoEventsWeb.EventController do
  use OctoEventsWeb, :controller

  alias OctoEvents.CreateEvent

  def create(conn, %{"payload" => payload}) do
    event_type = get_req_header(conn, "x-github-event")
    decoded_payload = Jason.decode!(payload)

    case CreateEvent.run(event_type, decoded_payload) do
      {:check, _} ->
        json(conn, "I'm alive")

      {:ok, event} ->
        conn
        |> put_status(:created)
        |> render("event.json", %{event: event})

      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{status: "unprocessable entity"})
    end
  end
end
