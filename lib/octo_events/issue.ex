defmodule OctoEvents.Issue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "issues" do
    field :body, :string
    field :html_url, :string
    field :number, :integer
    field :state, :string
    field :title, :string

    has_many :events, {"issue_events", Event}, foreign_key: :transactionable_id

    timestamps()
  end

  @doc false
  def changeset(issue, attrs) do
    issue
    |> cast(attrs, [:html_url, :number, :title, :state, :body])
    |> validate_required([:html_url, :number, :title, :state, :body])
  end
end
