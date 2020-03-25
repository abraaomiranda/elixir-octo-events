defmodule OctoEvents.CreateIssueEventTest do
  use OctoEvents.DataCase, async: true

  alias OctoEvents.{CreateIssueEvent, Event}

  import OctoEvents.Factory

  describe "run/1" do
    test "returns struct when the params are valid" do
      event_params = %{"action" => "open"}
      issue_params = string_params_for(:issue)

      assert {:ok, %Event{} = event} = CreateIssueEvent.run(issue_params, event_params)
      assert event.action == "open"
    end

    test "returns error when action is missing" do
      event_params = %{"action" => ""}
      issue_params = string_params_for(:issue)

      assert {:error, %Ecto.Changeset{} = changeset} =
               CreateIssueEvent.run(issue_params, event_params)

      %{action: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when cannot create issue" do
      event_params = %{"action" => "open"}
      issue_params = string_params_for(:issue, state: "")

      assert {:error, %Ecto.Changeset{} = changeset} =
               CreateIssueEvent.run(issue_params, event_params)

      %{state: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when cannot update issue" do
      saved_issue = insert(:issue)
      event_params = %{"action" => "open"}
      issue_params = string_params_for(:issue, number: saved_issue.number, state: "")

      assert {:error, %Ecto.Changeset{} = changeset} =
               CreateIssueEvent.run(issue_params, event_params)

      %{state: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
