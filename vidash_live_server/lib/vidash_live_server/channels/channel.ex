defmodule VidashLiveServer.Channels.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  @valid_roles ["TEXT", "AUDIO", "VIDEO"]
  @default_role "TEXT"

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "channels" do
    field :name, :string
    field :type, :string, default: @default_role

    belongs_to :user, VidashLiveServer.Users.User
    belongs_to :server, VidashLiveServer.Servers.Server

    # has_many :messages, YourApp.Message

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:name, :type, :user_id, :server_id])
    |> validate_role()
    |> validate_required([:name, :type, :user_id, :server_id])
  end

  defp validate_role(changeset) do
    type = get_field(changeset, :type)
    if type && !Enum.channel?(@valid_roles, type) do
      add_error(changeset, :type, "must be one of #{@valid_roles}")
    else
      changeset
    end
  end
end
