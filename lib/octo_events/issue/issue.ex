defmodule OctoEvents.Issue do
  use Ecto.Schema

  schema "issues" do
    field :body, :string
    field :html_url, :string
    field :number, :integer
    field :state, :string
    field :title, :string

    has_many :events, {"issue_events", OctoEvents.Event}, foreign_key: :transactionable_id

    timestamps()
  end

end
