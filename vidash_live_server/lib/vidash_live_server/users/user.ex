defmodule VidashLiveServer.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :full_name, :string
    field :gender, :string
    field :avatar, :string
    field :bio, :string
    belongs_to :account, VidashLiveServer.Accounts.Account

    # Define associations
    has_many :servers, VidashLiveServer.Servers.Server
    has_many :members, VidashLiveServer.Members.Member
    # has_many(:channels, VidashLiveServer.Channels.Channel)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:account_id, :full_name, :gender, :avatar, :bio])
    |> validate_required([:full_name])
  end
end
