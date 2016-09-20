defmodule SampleMicroservice.ConsumerControllerTest do
  use SampleMicroservice.ConnCase
  
  @valid_attrs %{ username: "phoenix_test" }
  @invalid_attrs %{ username: 1 }

  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  test "list all entries on consumers index", %{conn: conn} do
    conn = get conn, consumer_path(conn, :index) 
    assert json_response(conn, 200)["data"]
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, consumer_path(conn, :create), consumer: @valid_attrs
    #assert json_response(delete_conn, 404) =~ "Not Found"
    delete_conn = delete conn, consumer_path(conn, :delete, "phoenix_test")
    assert json_response(conn, 201)["data"]["id"]
  end

  test "gets 404 when trying to delete a data that doesnt exist", %{conn: conn} do
    conn = delete conn, consumer_path(conn, :delete, "thisuserdoesntexistsdude300000")
    assert json_response(conn, 404)["errors"]["detail"] =~ "Page not found"
  end

  test "deletes chosen resource", %{conn: conn} do
    #first create smth
    post conn, consumer_path(conn, :create), consumer: @valid_attrs
    conn = delete conn, consumer_path(conn, :delete, @valid_attrs.username)
    assert 204 == conn.status
  end
end
