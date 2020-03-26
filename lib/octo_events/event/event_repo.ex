defmodule OctoEvents.EventRepo do
  @moduledoc """
  Event repository
  """

  alias OctoEvents.Repo

  @spec all_by_issue(any) :: any
  def all_by_issue(issue) do
    Repo.all(Ecto.assoc(issue, :events))
  end
end
