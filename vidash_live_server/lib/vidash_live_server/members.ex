defmodule VidashLiveServer.Members do
  @moduledoc """
  The Members context.
  """

  import Ecto.Query, warn: false
  alias VidashLiveServer.Repo

  alias VidashLiveServer.Members.Member
  alias VidashLiveServer.Servers.Server
  alias VidashLiveServer.Members

  @doc """
  Returns the list of members.

  ## Examples

      iex> list_members()
      [%Member{}, ...]

  """
  def list_members do
    Repo.all(Member)
  end

  @doc """
  Gets a single member.

  Raises `Ecto.NoResultsError` if the Member does not exist.

  ## Examples

      iex> get_member!(123)
      %Member{}

      iex> get_member!(456)
      ** (Ecto.NoResultsError)

  """
  def get_member!(id), do: Repo.get!(Member, id)

  @doc """
  Get a member of default server using user id.
  """
  def get_member_user(id) do
    server_id = Members.default_server_id

    case Repo.one(from m in Member, where: m.user_id == ^id and m.server_id == ^server_id, select: m) do
      nil -> {:error, "No member found for the user"}
      member -> member
    end
  end

  @doc """
  Creates a member.

  ## Examples

      iex> create_member(%{field: value})
      {:ok, %Member{}}

      iex> create_member(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_member(attrs \\ %{}) do
    %Member{}
    |> Member.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
    Create guest member for deafult server id and given user id
  """
  def create_member_user(user, attrs \\ %{}) do
    server_id = default_server_id()
    member_changeset = Member.changeset(%Member{user_id: user.id, server_id: server_id, role: "GUEST"}, attrs)
    Repo.insert(member_changeset)
  end

  @doc """
  Create member using server id and user id
  """
  def create_member_from_server(server_id, user_id, attrs \\ %{}) do
    IO.puts("---")
    member_changeset = %Member{user_id: user_id, server_id: server_id, role: "ADMIN"}
    |> Member.changeset(attrs)

    case Repo.insert(member_changeset) do
      {:ok, member} ->
      # Successfully inserted
      IO.puts("---Successfully inserted")

      {:ok, member}
      {:error, changeset} ->
      # Failed to insert, handle the error
      IO.puts("---Failed to insert, handle the error")

      {:error, changeset}
    end
  end

  @doc """
  Updates a member.

  ## Examples

      iex> update_member(member, %{field: new_value})
      {:ok, %Member{}}

      iex> update_member(member, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_member(%Member{} = member, attrs) do
    member
    |> Member.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a member.

  ## Examples

      iex> delete_member(member)
      {:ok, %Member{}}

      iex> delete_member(member)
      {:error, %Ecto.Changeset{}}

  """
  def delete_member(%Member{} = member) do
    Repo.delete(member)
  end

  @doc """
    Delete all members of server before deleting server
  """
  def delete_members_server(server_id, attrs \\ %{}) do
    from(m in Member, where: m.server_id == ^server_id)
    |> Repo.delete_all()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking member changes.

  ## Examples

      iex> change_member(member)
      %Ecto.Changeset{data: %Member{}}

  """
  def change_member(%Member{} = member, attrs \\ %{}) do
    Member.changeset(member, attrs)
  end

  def default_server_id do
    default_id = case System.get_env("MIX_ENV") do
      "prod" ->
        # Code specific to production environment
        "de163efc-7284-4f75-ac5d-cfc6d8d94d01"
      "dev" ->
        # Code specific to development environment
        "2eb83025-a0df-468e-becb-2d1ae433328a"
    end
    default_id
  end
end
