defmodule OctoEvents.UpdateIssue do
  @moduledoc """
  Update an issue
  """

  import Ecto.Changeset

  alias OctoEvents.Repo

  def run(issue, attrs) do
    issue
    |> cast(attrs, [:html_url, :title, :state, :body])
    |> validate_required([:html_url, :state])
    |> Repo.update
  end
end
