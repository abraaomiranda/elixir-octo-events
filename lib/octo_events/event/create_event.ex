defmodule OctoEvents.CreateEvent do
  @moduledoc """
  Proxy module to create an specific type of event
  """

  def run(["issues"], %{"action" => action, "issue" => issue_attributes}) do
    OctoEvents.CreateIssueEvent.run(issue_attributes, %{"action" => action})
  end

  def run(["issues"], _) do
    {:error, :unprocessable_entity}
  end

  def run(["ping"], _) do
    {:check, :alive}
  end

  def run(_, _) do
    {:error, :unmapped}
  end
end
