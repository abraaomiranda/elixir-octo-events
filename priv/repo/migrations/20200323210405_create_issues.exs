defmodule OctoEvents.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :html_url, :string
      add :number, :integer, null: false
      add :title, :string
      add :state, :string
      add :body, :text

      timestamps()
    end

    create index(:issues, [:number])
  end
end
