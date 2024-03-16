defmodule VidashLiveServerWeb.ImageController do
    use VidashLiveServerWeb, :controller

    alias VidashLiveServer.{ Images, Images.Image }

    action_fallback VidashLiveServerWeb.FallbackController

    def show(conn, %{"id" => id}) do
        image = Images.get_image!(id)
      render(conn, :show, image: image)
    end

    def create(conn,  %{"image" => image_params}) do
      case Images.create_image(image_params) do
        {:ok, %Image{} = image} ->
          conn
          |> put_status(:created)
          |> put_resp_header("location", ~s"/api/images/#{image.id}")
          |> render(:show, image: image)

        {:error, error} ->
          conn
          |> put_status(:unprocessable_entity)
          |> render("error.json", %{message: "Failed to create image", error: inspect(error)})
      end
    end
end
