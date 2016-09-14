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
    assert json_response(conn, 201)["data"]["id"]
  end
end
