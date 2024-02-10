defmodule VidashLiveServer.Members.Member do
  use Ecto.Schema
  import Ecto.Changeset

  @valid_roles ["ADMIN", "MODERATOR", "GUEST"]
  @default_role "GUEST"

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "members" do
    field :role, :string, default: @default_role
    belongs_to :user, VidashLiveServer.Users.User
    belongs_to :server, VidashLiveServer.Servers.Server

    # has_many(:messages, YourApp.Message)
    # has_many(:direct_messages, YourApp.DirectMessage)

    # has_many(:conversations_initiated, YourApp.Conversation, foreign_key: :member_one_id)
    # has_many(:conversations_received, YourApp.Conversation, foreign_key: :member_two_id)


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [:role, :user_id, :server_id])
    |> validate_role()
    |> validate_required([])
  end

  defp validate_role(changeset) do
    role = get_field(changeset, :role)
    if role && !Enum.member?(@valid_roles, role) do
      add_error(changeset, :role, "must be one of #{@valid_roles}")
    else
      changeset
    end
  end
end
