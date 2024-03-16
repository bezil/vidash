defmodule VidashLiveServerWeb.ImageJSON do
    alias VidashLiveServer.Images.Image

    @doc """
    Renders a list of images.
    """
    def showlist(%{images: images}) do
      %{images: for(image <- images, do: data(image))}
    end

    @doc """
    Renders a single image.
    """
    def show(%{image: image}) do
      %{details: data(image)}
    end

    defp data(%Image{} = image) do
      %{
        id: image.id,
        type: image.type,
        secure_url: image.secure_url,
        public_id: image.public_id,
        title: image.title,
        width: image.width,
        height: image.height,
        config: image.config,
        transformation_url: image.transformation_url,
        aspect_ratio: image.aspect_ratio,
        color: image.color,
        prompt: image.prompt,
        author: image.author,
      }
    end
  end
