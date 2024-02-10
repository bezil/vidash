defmodule VidashLiveServer.ServersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VidashLiveServer.Servers` context.
  """

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        image_url: "some image_url",
        invite_code: "some invite_code",
        name: "some name"
      })
      |> VidashLiveServer.Servers.create_server()

    server
  end
end
