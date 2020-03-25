defmodule OctoEvents.IssueRepo do
  @moduledoc """
  Issue repositoty
  """

  alias OctoEvents.{Issue, Repo}

  def get_by_number(number) do
    Repo.get_by(Issue, number: number)
  end
end
