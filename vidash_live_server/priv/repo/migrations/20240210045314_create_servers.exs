defmodule VidashLiveServer.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :image_url, :string
      add :invite_code, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end
  end
end
