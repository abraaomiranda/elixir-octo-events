defmodule OctoEvents.CreateIssueTest do
  use OctoEvents.DataCase, async: true

  alias OctoEvents.{CreateIssue, Issue}

  describe "run/1" do
    test "returns struct when the params are valid" do
      params = %{
        "html_url" => "https://github.com/octo_events/",
        "number" => 1,
        "title" => "An incredible title",
        "state" => "open",
        "body" => "A summer body"
      }

      assert {:ok, %Issue{} = issue} = CreateIssue.run(params)
      assert issue.html_url == "https://github.com/octo_events/"
      assert issue.number == 1
      assert issue.title == "An incredible title"
      assert issue.state == "open"
      assert issue.body == "A summer body"
    end

    test "returns error when number is missing" do
      params = %{
        "html_url" => "https://github.com/octo_events/",
        "number" => nil,
        "title" => "An incredible title",
        "state" => "open",
        "body" => "A summer body"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateIssue.run(params)
      %{number: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when html_url is missing" do
      params = %{
        "html_url" => "",
        "number" => 1,
        "title" => "An incredible title",
        "state" => "open",
        "body" => "A summer body"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateIssue.run(params)
      %{html_url: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when state is missing" do
      params = %{
        "html_url" => "https://github.com/octo_events/",
        "number" => 1,
        "title" => "An incredible title",
        "state" => "",
        "body" => "A summer body"
      }

      assert {:error, %Ecto.Changeset{} = changeset} = CreateIssue.run(params)
      %{state: ["can't be blank"]} = errors_on(changeset)
    end
  end
end
