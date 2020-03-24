defmodule OctoEvents.CreateIssueEvent do
  @moduledoc """
  Create an issue event
  """

  import Ecto.Changeset

  alias OctoEvents.{CreateIssue, Issue, IssueRepo, Repo, UpdateIssue}

  def run(issue_attributes, event_attributes) do
    case create_or_update_issue(issue_attributes) do
      {:ok, issue} ->
        create_event(issue, event_attributes)
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  defp create_event(issue, event_attributes) do
    issue
    |> Ecto.build_assoc(:events)
    |> cast(event_attributes, [:action])
    |> validate_required([:action, :transactionable_id])
    |> Repo.insert
  end

  defp create_or_update_issue(%{"number" => number} = issue_attributes) do
    case IssueRepo.get_by_number(number) do
      %Issue{} = issue ->
        UpdateIssue.run(issue, issue_attributes)
      nil ->
        CreateIssue.run(issue_attributes)
    end
  end
end
