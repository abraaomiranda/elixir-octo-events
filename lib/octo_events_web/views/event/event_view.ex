defmodule OctoEventsWeb.EventView do
  use OctoEventsWeb, :view

  def render("event.json", %{event: event})do
    %{
      status: :ok,
      data: %{
        action: event.action,
        inserted_at: event.inserted_at
      }
    }
  end
end
