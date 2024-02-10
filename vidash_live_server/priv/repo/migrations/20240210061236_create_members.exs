defmodule VidashLiveServer.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :role, :string, default: "GUEST"
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :server_id, references(:servers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:members, [:user_id])
    create index(:members, [:server_id])
  end
end
