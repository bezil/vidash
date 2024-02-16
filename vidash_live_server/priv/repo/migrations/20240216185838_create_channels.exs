defmodule VidashLiveServer.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :type, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :server_id, references(:servers, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:channels, [:user_id])
    create index(:channels, [:server_id])
  end
end
