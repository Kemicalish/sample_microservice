defmodule SampleMicroservice.ServiceCredentialsTest do
  use SampleMicroservice.ConnCase
  alias SampleMicroservice.ServiceCredentials
  alias SampleMicroservice.KongAdminRepo

  @tag :external
  test "From raw structure to %ServiceCredentials struct" do
    service_credentials = KongAdminRepo.get(ServiceCredentials, "70ea6c80-a06e-4226-844d-7f073da753aa")
    assert "userman-services-elixir" = service_credentials.name
  end

  @tag :external
  test "Get by service name the service infos" do
    service_credentials = KongAdminRepo.get_by(ServiceCredentials,:client_id,"userman-services-elixir")
    assert "userman-services-elixir" = service_credentials.client_id
  end

  @tag :external
  test "Gets 404 when service is unknown trying to get by service info" do
    service_not_found = KongAdminRepo.get_by(ServiceCredentials, :client_id, "noneosndsonfsodnf")
    assert nil == service_not_found
  end

  @tag :external
  test "From raw service credentials list to list of %ServiceCredentials.struct" do
    [first_credentials | _credentials] = KongAdminRepo.all(ServiceCredentials) 
    assert "userman-services-elixir" = first_credentials.name
  end
end
