defmodule OctoEventsWeb.EventView do
  use OctoEventsWeb, :view

  def render("event.json", %{event: event}) do
    %{
      status: :ok,
      data: event
    }
  end
end
