defmodule SampleMicroservice.AccessController do
  use SampleMicroservice.Web, :controller

  alias SampleMicroservice.OauthToken
  alias SampleMicroservice.KongAdminRepo
  alias SampleMicroservice.ServiceCredentials

  plug :scrub_params, "login" when action in [:create]

  defp check_account(login, password) do
    %{
      id: "test",
      name: login,
      password_hash: Comeonin.Bcrypt.hashpwsalt(password)
    }
  end

  defp token_form_data(service_credentials) do
    IO.inspect service_credentials
    [
      {"grant_type", "password"},
      {"cient_id", service_credentials.client_id},
      {"client_secret", service_credentials.client_secret},
      {"provision_key", "testtestdudeman"}, 
      {"authenticated_userid", "admin"},
      {"scope","guest"},
      {"password", "sg123456"}
    ]
  end

  def create(conn, %{ "login" => login_params = %{ "service_id" => service_id, "login" => login, "password" => password} } ) do
    %{id: id, name: name, password_hash: password_hash} = check_account(login, password)
    credentials = KongAdminRepo.get_by(ServiceCredentials, :client_id, service_id)
    #{:ok, service}  = KongAdminRepo.get_all(ServiceCredentials, service_id)
    {:ok, token}    = KongAdminRepo.insert(OauthToken, {:form, token_form_data(credentials)})

    conn 
      |> put_status(:created)
      |> render("show.json", user_access: token)
  end
end
