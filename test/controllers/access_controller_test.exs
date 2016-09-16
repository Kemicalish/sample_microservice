defmodule SampleMicroservice.AccessControllerTest do
  use SampleMicroservice.ConnCase
  
  @valid_attrs %{ login: "phoenix_test", password: "phoenix", service_id: "test_service"}
  @invalid_attrs %{ login: "1", password: "a", service_id: "no_service" }

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, access_path(conn, :create), login: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
  end

  test "gets a forbidden status when credentials are inalid" do
    conn = post conn, access_path(conn, :create), login: @invalid_attrs
    assert json_response(conn, 401)["errors"]["detail"]
  end
end
