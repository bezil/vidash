defmodule VidashLiveServer.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VidashLiveServer.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        avatar: "some avatar",
        bio: "some bio",
        full_name: "some full_name",
        gender: "some gender"
      })
      |> VidashLiveServer.Users.create_user()

    user
  end
end
