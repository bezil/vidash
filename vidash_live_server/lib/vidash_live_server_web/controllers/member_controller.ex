defmodule VidashLiveServerWeb.MemberController do
    use VidashLiveServerWeb, :controller

    alias VidashLiveServer.{ Members, Members.Member }

    action_fallback VidashLiveServerWeb.FallbackController

    def show(conn, %{"id" => id}) do
      server = Members.get_server!(id)
      render(conn, :show, server: server)
    end

    def create(conn,  %{"member" => member_params}) do
      case Members.create_member(member_params) do
        {:ok, %Member{} = member} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", ~s"/api/members/#{member.id}")
          |> render(:show, member: member)

        {:error, error} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render("error.json", %{message: "Failed to create member", error: inspect(error)})
      end
    end
end
