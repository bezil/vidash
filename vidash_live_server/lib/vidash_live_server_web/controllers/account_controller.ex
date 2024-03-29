defmodule VidashLiveServerWeb.AccountController do
  use VidashLiveServerWeb, :controller

  alias VidashLiveServerWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias VidashLiveServer.{Accounts, Accounts.Account, Users, Users.User, Members, Members.Member}

  action_fallback VidashLiveServerWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
    {:ok, token, _claims} <- Guardian.encode_and_sign(account),
    {:ok, %User{} = user} <- Users.create_user(account, account_params),
    {:ok, %Member{} = member} <- Members.create_member_user(user) do
      conn
      |> put_status(:created)
      |> render(:account_token, %{account: account, user: user, token: token})
      end
  end

  def login(conn, %{"email" => email, "hashed_password" => hashed_password}) do
    case Guardian.authenticate(email, hashed_password) do
      {:ok, account, token} ->
        # conn = put_session(conn, :account_id, account.id)
        # message = get_session(conn, :account_id)
        # IO.puts("---------#{message}")
        conn
        |> put_status(:ok)
        |> render(:account_token, %{account: account, token: token})
      {:error, :unauthorized} ->
        raise ErrorResponse.Unauthorized, message: "Email or Password incorrect."
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
