defmodule VidashLiveServer.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "servers" do
    field :name, :string
    field :image_url, :string
    field :invite_code, :string

    belongs_to :user, VidashLiveServer.Users.User
    # has_many :members, VidashLiveServer.Members.Member
    # has_many :channels, VidashLiveServer.Channels.Channel

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :image_url, :invite_code])
    |> validate_required([:name, :image_url, :invite_code])
  end
end
