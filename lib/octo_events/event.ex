defmodule OctoEvents.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "abstract table: events" do
    field :action, :string
    field :transactionable_id, :string

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:action, :transactionable_id])
    |> validate_required([:action, :transactionable_id])
  end
end
