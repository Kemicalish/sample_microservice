defmodule SampleMicroservice.AccessControllerTest do
  use SampleMicroservice.ConnCase

  alias SampleMicroservice.User
  
  @valid_attrs %{ login: "phoenix_test_user",  name: "phoenix_test_user", password_hash: "Spo9s90s1mLonI2jK34O2mlsL39SoAk", password: "S3cr3t_Dud3", service_id: "django-services-todos"}
  @invalid_attrs %{ login: "1", password: "a", service_id: "django-services-todos" }

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  @tag :external
  test "creates resource and redirects when data is valid", %{conn: conn} do
    Repo.insert(User.registration_changeset(%User{}, %{ name: @valid_attrs.name, password: @valid_attrs.password }))
    conn = post conn, access_path(conn, :create), login: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
  end

  @tag :external
  test "gets a forbidden status when credentials are invalid" do
    conn = post conn, access_path(conn, :create), login: @invalid_attrs
    assert json_response(conn, 401)["errors"]["detail"]
  end
end
