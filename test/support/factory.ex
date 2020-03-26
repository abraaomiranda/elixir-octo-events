defmodule OctoEvents.Factory do
  @moduledoc """
  Factory
  """
  use ExMachina.Ecto, repo: OctoEvents.Repo

  def event do
    %OctoEvents.Event{
      action: "open"
    }
  end

  def issue_factory do
    %OctoEvents.Issue{
      html_url: "https://github.com/octo_events/",
      number: 1,
      title: "An incredible title",
      state: "open",
      body: "A summer body"
    }
  end
end
