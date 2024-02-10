defmodule VidashLiveServerWeb.ServerController do
    use VidashLiveServerWeb, :controller

    alias VidashLiveServer.Servers

    action_fallback VidashLiveServerWeb.FallbackController

    def show(conn, %{"id" => id}) do
      server = Servers.get_server!(id)
      render(conn, :show, server: server)
    end

    def show_from_user(conn, %{"user_id" => id}) do
        server = Servers.get_server_from_user(id)
        case server do
          {:error, errormessage} ->
          conn
          |> put_status(:not_found)
          |> text("#{errormessage}")
          {:ok, server} -> render(conn, :show, server: server)
        end
    end
  end
