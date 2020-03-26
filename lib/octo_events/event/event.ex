defmodule OctoEvents.Event do
  @moduledoc """
  Event schema
  """

  # @michel ?
  @derive {Jason.Encoder, only: [:action, :inserted_at]}

  use Ecto.Schema

  schema "abstract table: events" do
    field :action, :string
    field :transactionable_id, :integer

    timestamps()
  end
end
