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
    plug :fetch_session
  end

  pipeline :auth do
    plug VidashLiveServerWeb.Auth.Pipeline
    # plug VidashLiveServerWeb.Auth.SetAccount
  end

  scope "/api", VidashLiveServerWeb do
    pipe_through :api

    post "/signup", AccountController, :create
    post "/signin", AccountController, :login
  end

  scope "/api", VidashLiveServerWeb do
    pipe_through [:api, :auth]

    get "/accounts/:id", AccountController, :show
    get "/users/:account_id", UserController, :show_from_account
    post "/users/:id/update", UserController, :update

    get "/uploads/request_url", UploadController, :create_signed_url

    get "/servers/:id", ServerController, :show
    delete "/servers/:id", ServerController, :delete
    get "/servers/by_user_id/:user_id", ServerController, :show_from_user
    post "/servers/add", ServerController, :add_server_user

    get "/members/by_user_id/:user_id", MemberController, :show_from_user

    post "/images/add", ImageController, :create
  end
end
