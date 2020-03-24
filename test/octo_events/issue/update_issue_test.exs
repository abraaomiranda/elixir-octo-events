defmodule OctoEvents.UpdateIssueTest do
  use OctoEvents.DataCase, async: true

  alias OctoEvents.{UpdateIssue, Issue}

  import OctoEvents.Factory

  describe "run/1" do
    setup do
      %{saved_issue: insert(:issue)}
    end

    test "returns struct when the params are valid", %{saved_issue: saved_issue} do
      params = %{
        "html_url" => "https://github.com/octo_events/updated_url",
        "title" => "Updated title",
        "state" => "updated",
        "body" => "updated summer body"
      }

      assert {:ok, %Issue{} = issue} = UpdateIssue.run(saved_issue, params)
      assert issue.html_url == "https://github.com/octo_events/updated_url"
      assert issue.title == "Updated title"
      assert issue.state == "updated"
      assert issue.body == "updated summer body"
    end

    test "do not update number", %{saved_issue: saved_issue} do
      params = %{
        "number" => saved_issue.number + 1
      }

      assert {:ok, %Issue{} = issue} = UpdateIssue.run(saved_issue, params)
      assert issue.number == saved_issue.number
    end

    test "returns error when html_url is missing", %{saved_issue: saved_issue} do
      params = %{
        "html_url" => ""
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateIssue.run(saved_issue, params)
      %{html_url: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when state is missing", %{saved_issue: saved_issue} do
      params = %{
        "state" => ""
      }

      assert {:error, %Ecto.Changeset{} = changeset} = UpdateIssue.run(saved_issue, params)
      %{state: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
