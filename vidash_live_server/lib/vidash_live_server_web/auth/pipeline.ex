defmodule VidashLiveServerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :vidash_live_server,
  module: VidashLiveServerWeb.Auth.Guardian,
  error_handler: VidashLiveServerWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
