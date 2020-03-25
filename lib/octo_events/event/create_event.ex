defmodule OctoEvents.CreateEvent do
  @moduledoc """
  Proxy module to create an specific type of event
  """

  def run(["issue"], %{"action" => action, "issue" => issue_attributes}) do
    OctoEvents.CreateIssueEvent.run(issue_attributes, %{action: action})
  end

  def run(_, _) do
    {:error, "unprocessable entity"}
  end
end
