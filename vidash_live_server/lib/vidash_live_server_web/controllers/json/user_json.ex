defmodule VidashLiveServerWeb.UserJSON do
  alias VidashLiveServer.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{details: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      full_name: user.full_name,
      gender: user.gender,
      avatar: user.avatar,
      bio: user.bio
    }
  end
end
