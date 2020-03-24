defmodule OctoEvents.CreateIssue do
  @moduledoc """
  Create an issue
  """

  import Ecto.Changeset

  alias OctoEvents.{Issue, Repo}

  def run(attrs) do
    %Issue{}
    |> cast(attrs, [:html_url, :number, :title, :state, :body])
    |> validate_required([:html_url, :number, :state])
    |> Repo.insert
  end
end
