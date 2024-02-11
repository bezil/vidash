defmodule VidashLiveServerWeb.Auth.SetAccount do
    import Plug.Conn

    alias VidashLiveServer.Accounts
    alias VidashLiveServerWeb.Auth.ErrorResponse

    def init(default), do: default

    def call(conn, _options) do
        IO.inspect(conn)
        if conn.assigns[:account] do
          conn
        else
          account_id = get_session(conn, :account_id)

          case account_id do
            nil ->
              raise ErrorResponse.Unauthorized

            _ ->
              account = Accounts.get_account!(account_id)
              assign(conn, :account, account)
          end
        end
      end
  end
