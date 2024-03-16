defmodule VidashLiveServer.Images.Image do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "images" do
    field :type, :string
    field :config, :string
    field :title, :string
    field :prompt, :string
    field :width, :string
    field :color, :string
    field :public_id, :string
    field :secure_url, :string
    field :height, :string
    field :transformation_url, :string
    field :aspect_ratio, :string
    belongs_to :author, VidashLiveServer.Members.Member

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:title, :public_id, :secure_url, :type, :config, :width, :height, :transformation_url, :aspect_ratio, :color, :prompt])
    |> validate_required([:title, :public_id, :secure_url, :type])
  end
end
