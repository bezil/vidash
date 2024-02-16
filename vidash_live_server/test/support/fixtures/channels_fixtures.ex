defmodule VidashLiveServer.ChannelsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VidashLiveServer.Channels` context.
  """

  @doc """
  Generate a channel.
  """
  def channel_fixture(attrs \\ %{}) do
    {:ok, channel} =
      attrs
      |> Enum.into(%{
        name: "some name",
        type: "some type"
      })
      |> VidashLiveServer.Channels.create_channel()

    channel
  end
end
