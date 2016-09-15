defmodule SampleMicroservice.OauthTokenTest do
  use SampleMicroservice.ConnCase
  alias SampleMicroservice.OauthToken
  alias SampleMicroservice.KongAdminRepo

  @tag :external
  test "get a new token for a test service using existing credentials of a user" do
    service_credentials = KongAdminRepo.get(ServiceCredentials, "70ea6c80-a06e-4226-844d-7f073da753aa")
    assert "userman-services-elixir" = service_credentials.name
  end

  @tag :external
  test "From raw service credentials list to list of %ServiceCredentials.struct" do
    [first_credentials | _credentials] = KongAdminRepo.all(ServiceCredentials) 
    assert "userman-services-elixir" = first_credentials.name
  end
end
