defmodule VidashLiveServer.Members do
  @moduledoc """
  The Members context.
  """

  import Ecto.Query, warn: false
  alias VidashLiveServer.Repo

  alias VidashLiveServer.Members.Member
  alias VidashLiveServer.Servers.Server

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
end
