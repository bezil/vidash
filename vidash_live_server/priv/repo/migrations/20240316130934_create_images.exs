defmodule VidashLiveServer.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :public_id, :string
      add :secure_url, :text
      add :type, :string
      add :config, :string
      add :width, :string
      add :height, :string
      add :transformation_url, :text
      add :aspect_ratio, :string
      add :color, :string
      add :prompt, :string
      add :author, references(:members, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:images, [:author])
  end
end
