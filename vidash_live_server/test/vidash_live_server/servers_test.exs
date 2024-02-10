defmodule VidashLiveServer.ServersTest do
  use VidashLiveServer.DataCase

  alias VidashLiveServer.Servers

  describe "servers" do
    alias VidashLiveServer.Servers.Server

    import VidashLiveServer.ServersFixtures

    @invalid_attrs %{name: nil, image_url: nil, invite_code: nil}

    test "list_servers/0 returns all servers" do
      server = server_fixture()
      assert Servers.list_servers() == [server]
    end

    test "get_server!/1 returns the server with given id" do
      server = server_fixture()
      assert Servers.get_server!(server.id) == server
    end

    test "create_server/1 with valid data creates a server" do
      valid_attrs = %{name: "some name", image_url: "some image_url", invite_code: "some invite_code"}

      assert {:ok, %Server{} = server} = Servers.create_server(valid_attrs)
      assert server.name == "some name"
      assert server.image_url == "some image_url"
      assert server.invite_code == "some invite_code"
    end

    test "create_server/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Servers.create_server(@invalid_attrs)
    end

    test "update_server/2 with valid data updates the server" do
      server = server_fixture()
      update_attrs = %{name: "some updated name", image_url: "some updated image_url", invite_code: "some updated invite_code"}

      assert {:ok, %Server{} = server} = Servers.update_server(server, update_attrs)
      assert server.name == "some updated name"
      assert server.image_url == "some updated image_url"
      assert server.invite_code == "some updated invite_code"
    end

    test "update_server/2 with invalid data returns error changeset" do
      server = server_fixture()
      assert {:error, %Ecto.Changeset{}} = Servers.update_server(server, @invalid_attrs)
      assert server == Servers.get_server!(server.id)
    end

    test "delete_server/1 deletes the server" do
      server = server_fixture()
      assert {:ok, %Server{}} = Servers.delete_server(server)
      assert_raise Ecto.NoResultsError, fn -> Servers.get_server!(server.id) end
    end

    test "change_server/1 returns a server changeset" do
      server = server_fixture()
      assert %Ecto.Changeset{} = Servers.change_server(server)
    end
  end
end
