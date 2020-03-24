defmodule OctoEvents.Event do
  use Ecto.Schema

  schema "abstract table: events" do
    field :action, :string
    field :transactionable_id, :integer

    timestamps()
  end
end
