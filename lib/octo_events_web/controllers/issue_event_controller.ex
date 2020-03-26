defmodule OctoEventsWeb.IssueEventController do
  use OctoEventsWeb, :controller

  alias OctoEvents.{EventRepo, IssueRepo}

  def index(conn, %{"number" => number}) do
    case IssueRepo.get_by_number(number) do
      nil ->
        conn
        |> put_status(404)
        |> json(%{status: "Not found"})

      issue ->
        events = EventRepo.all_by_issue(issue)
        render(conn, "index.json", %{events: events})
    end
  end
end
