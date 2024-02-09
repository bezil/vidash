defmodule VidashLiveServerWeb.Router do
  use VidashLiveServerWeb, :router
  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  def handle_errors(conn, %{reason: %{message: message}}) do
    conn |> json(%{errors: message}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug VidashLiveServerWeb.Auth.Pipeline
  end

  scope "/api", VidashLiveServerWeb do
    pipe_through :api

    post "/signup", AccountController, :create
    post "/signin", AccountController, :login
  end

  scope "/api", VidashLiveServerWeb do
    pipe_through [:api, :auth]

    get "/", DefaultController, :home
    get "/accounts/:id", AccountController, :show
    get "/users/:account_id", UserController, :show_from_account
  end
end
