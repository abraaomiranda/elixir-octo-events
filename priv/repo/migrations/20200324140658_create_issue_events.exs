defmodule OctoEvents.Repo.Migrations.CreateIssueEvents do
  use Ecto.Migration

  def change do
    create table(:issue_events) do
      add :action, :string, null: false
      add :transactionable_id, references(:issues), null: false

      timestamps()
    end

  end
end
