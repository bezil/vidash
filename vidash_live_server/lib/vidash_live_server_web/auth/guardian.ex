defmodule VidashLiveServerWeb.Auth.Guardian do
  use Guardian, otp_app: :vidash_live_server

  alias VidashLiveServer.Accounts

  def subject_for_token(%{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _claims) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_account!(id) do
      nil -> {:error, :resource_not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_) do
    {:error, :no_id_provided}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil -> {:error, :unauthorized}
      account ->
        case validate_password(password, account.hashed_password) do
          true -> create_token(account)
          false -> {:error, :unauthorized}
        end

    end
  end

  defp validate_password(password, hashed_password) do
    Bcrypt.verify_pass(password, hashed_password)
  end

  defp create_token(account) do
    {:ok, token, _claims} = encode_and_sign(account, ttl: {2, :hour})
    {:ok, account, token}
  end
end
