defmodule VidashLiveServerWeb.DefaultController do
  use VidashLiveServerWeb, :controller

  def home(conn, _params) do
    text(conn, "Home Page")
  end
end
