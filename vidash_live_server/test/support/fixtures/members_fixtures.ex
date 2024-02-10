defmodule VidashLiveServer.MembersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VidashLiveServer.Members` context.
  """

  @doc """
  Generate a member.
  """
  def member_fixture(attrs \\ %{}) do
    {:ok, member} =
      attrs
      |> Enum.into(%{

      })
      |> VidashLiveServer.Members.create_member()

    member
  end
end
