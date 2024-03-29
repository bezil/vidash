defmodule VidashLiveServerWeb.ServerJSON do
    alias VidashLiveServer.Servers.Server

    @doc """
    Renders a list of servers.
    """
    def showlist(%{servers: servers}) do
      %{servers: for(server <- servers, do: data(server))}
    end

    @doc """
    Renders a single server.
    """
    def show(%{server: server}) do
      %{details: data(server)}
    end

    defp data(%Server{} = server) do
      %{
        id: server.id,
        name: server.name,
        image_url: server.image_url
      }
    end
  end
