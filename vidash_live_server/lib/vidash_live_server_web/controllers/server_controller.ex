defmodule VidashLiveServerWeb.ServerController do
    use VidashLiveServerWeb, :controller

    alias VidashLiveServer.{Users, Servers, Members, Servers.Server}

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
          _ -> render(conn, :show, server: server)
        end
    end

    def create(conn, %{"server" => server_params}) do
      case Servers.create_server(server_params) do
        {:ok, %Server{} = server} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", ~s"/api/servers/#{server.id}")
          |> render(:show, server: server)

        {:error, error} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render("error.json", %{message: "Failed to create server", error: inspect(error)})
      end
    end

    def create_server_user(conn, %{"acc_id" => acc_id, "server" => server} = params) do
      case acc_id do
        "" ->
          conn
          |> put_status(:unprocessable_entity)
          |> render("error.json", %{message: "acc_id is required"})

        _ ->
          case Users.get_user_by_account(acc_id) do
            nil ->
              conn
              |> put_status(:not_found)
              |> render("error.json", %{message: "Failed to retrieve user"})

            user ->
              case Servers.create_server(user, server) do
                {:ok, %Server{} = created_server} ->
                  new_server = Servers.get_server_from_user(user.id)
                  member = Members.create_member_from_server(new_server.id, user.id)
                  conn
                  |> put_status(:created)
                  |> put_resp_header("location", "/api/servers/#{created_server.id}")
                  |> render(:show, server: created_server)

                {:error, changeset} ->
                  conn
                  |> put_status(:unprocessable_entity)
                  |> render("error.json", %{message: "Failed to create server"})
              end
          end
      end
    end
end
