defmodule UserManager.AccessController do
  use UserManager.Web, :controller

  alias UserManager.OauthToken
  alias UserManager.KongAdminRepo
  alias UserManager.ServiceCredentials
  alias UserManager.User
  alias UserManager.KongRepo

  plug :scrub_params, "login" when action in [:create]

  defp check_account(name, password) do
    with user = %{id: id, name: name, password_hash: password_hash} <- Repo.get_by(User, name: name), 
    {:ok, true} <- check_password(password, password_hash) do user
    else 
      _ -> { :error, :forbidden }
    end
  end

  defp check_password(password_in, password_hash) do
    case Comeonin.Bcrypt.checkpw(password_in, password_hash) do
      true -> {:ok, true}
      false -> {:error, :forbidden}
    end
  end

  defp token_form_data(service_credentials) do
    [
      {"grant_type", "password"},
      {"client_id", service_credentials.client_id},
      {"client_secret", service_credentials.client_secret},
      {"provision_key", "6g21adb99b8c41789ed955d421682cc7"}, 
      {"authenticated_userid", "admin"},
      {"scope","guest"},
      {"username", "admin"}, 
      {"password", "sg123456"}
    ]
  end

  def create(conn, %{ "login" => login_params = %{ "service_id" => service_id, "login" => login, "password" => password} } ) do
    with %{id: id, name: name, password_hash: password_hash} <- check_account(login, password),
    credentials = %ServiceCredentials{} <- KongAdminRepo.get_by(ServiceCredentials, :client_id, service_id),
    post_data <- token_form_data(credentials),
    {:ok, token}    <- KongRepo.insert(OauthToken, {:form, post_data}) do conn
      |> put_status(:created)
      |> render("show.json", access: token)
    else 
      {:error, :forbidden} ->
        conn 
        |> put_status(:unauthorized)
        |> render(UserManager.ErrorView, "403.json")
    end
  end
end
