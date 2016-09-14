defmodule SampleMicroservice.ServiceCredentialsTest do

  use SampleMicroservice.ConnCase
  alias SampleMicroservice.ServiceCredentials
  alias SampleMicroservice.KongAdminRepo


  @tag :external
  test "From raw structure to %ServiceCredentials struct" do
    service_credentials = KongAdminRepo.get(ServiceCredentials, "5fefd80d-0780-4c90-b76f-d9d8ea7e020a")
    assert "django-services-todos" = service_credentials.name
  end

  @tag :external
  test "From raw service credentials list to list of %ServiceCredentials.struct" do
    [first_credentials | _credentials] = KongAdminRepo.all(ServiceCredentials) 
    IO.inspect first_credentials
    assert "django-services-todos" = first_credentials.name
  end

end

