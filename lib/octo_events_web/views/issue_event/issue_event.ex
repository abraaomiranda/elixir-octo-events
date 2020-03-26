defmodule OctoEventsWeb.IssueEventView do
  use OctoEventsWeb, :view

  def render("index.json", %{events: events}) do
    %{
      status: :ok,
      data: events
    }
  end
end
