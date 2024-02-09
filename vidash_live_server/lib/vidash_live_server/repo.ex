defmodule VidashLiveServer.Repo do
  use Ecto.Repo,
    otp_app: :vidash_live_server,
    adapter: Ecto.Adapters.Postgres
end
