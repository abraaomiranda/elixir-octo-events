defmodule OctoEventsWeb.EventViewTest do
  use ExUnit.Case, async: true

  alias OctoEventsWeb.EventView
  alias OctoEvents.Event

  describe "render/2 event.json" do
    test "returns ok and the event data" do
      event = %Event{inserted_at: ~U[2020-02-01 11:00:00Z], action: "open"}

      assert %{
               status: :ok,
               data: %{
                 action: "open",
                 inserted_at: ~U[2020-02-01 11:00:00Z]
               }
             } = EventView.render("event.json", %{event: event})
    end
  end
end
