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

  def create(conn, %{ "login" => login_params = %{ "service_id" => service_id, "login" => login, "password" => password} } ) do
    %{id: id, name: name, password_hash: password_hash} = check_account(login, password)
    IO.inspect ServiceCredentials.get_by_service_name(service_id)
    #{:ok, service}  = KongAdminRepo.get_all(ServiceCredentials, service_id)
    {:ok, token}    = KongAdminRepo.insert(OauthToken, login_params)

    conn 
      |> put_status(:created)
      |> render("show.json", user_access: token)
  end

end
