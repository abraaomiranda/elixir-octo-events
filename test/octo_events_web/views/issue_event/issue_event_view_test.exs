defmodule OctoEventsWeb.IssueEventViewTest do
  use ExUnit.Case, async: true

  alias OctoEvents.Event
  alias OctoEventsWeb.IssueEventView

  describe "render/2 index.json" do
    test "returns ok and the event data" do
      events = [%Event{inserted_at: ~U[2020-02-01 11:00:00Z], action: "open"}]

      assert %{
               status: :ok,
               data: [
                 %{
                   action: "open",
                   inserted_at: ~U[2020-02-01 11:00:00Z]
                 }
               ]
             } = IssueEventView.render("index.json", %{events: events})
    end
  end
end
