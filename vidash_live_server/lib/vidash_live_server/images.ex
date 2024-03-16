defmodule VidashLiveServer.Images do
    @moduledoc """
    The Images context.
    """

    import Ecto.Query, warn: false
    alias VidashLiveServer.Repo

    alias VidashLiveServer.Images.Image
    alias VidashLiveServer.Images

    @doc """
    Returns the list of Images.

    ## Examples

        iex> list_Images()
        [%Image{}, ...]

    """
    def list_images do
      Repo.all(Image)
    end

    @doc """
    Gets a single Image.

    Raises `Ecto.NoResultsError` if the Image does not exist.

    ## Examples

        iex> get_image!(123)
        %Image{}

        iex> get_image!(456)
        ** (Ecto.NoResultsError)

    """
    def get_image!(id), do: Repo.get!(Image, id)


    @doc """
    Creates a Image.

    ## Examples

        iex> create_image(%{field: value})
        {:ok, %Image{}}

        iex> create_image(%{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def create_image(attrs \\ %{}) do
      %Image{}
      |> Image.changeset(attrs)
      |> Repo.insert()
    end

    @doc """
    Updates a Image.

    ## Examples

        iex> update_image(Image, %{field: new_value})
        {:ok, %Image{}}

        iex> update_image(Image, %{field: bad_value})
        {:error, %Ecto.Changeset{}}

    """
    def update_image(%Image{} = image, attrs) do
      image
      |> Image.changeset(attrs)
      |> Repo.update()
    end

    @doc """
    Deletes a Image.

    ## Examples

        iex> delete_image(Image)
        {:ok, %Image{}}

        iex> delete_image(Image)
        {:error, %Ecto.Changeset{}}

    """
    def delete_image(%Image{} = image) do
      Repo.delete(image)
    end


    @doc """
    Returns an `%Ecto.Changeset{}` for tracking Image changes.

    ## Examples

        iex> change_image(Image)
        %Ecto.Changeset{data: %Image{}}

    """
    def change_image(%Image{} = image, attrs \\ %{}) do
      Image.changeset(image, attrs)
    end

  end
