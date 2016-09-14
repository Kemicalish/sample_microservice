defmodule SampleMicroservice.ConsumerControllerTest do
  use SampleMicroservice.ConnCase
  
  setup %{conn: conn} do
    {:ok, conn: conn}
  end

  test "list all entries on consumers index", %{conn: conn} do
    conn = get conn, consumer_path(conn, :index) 
    assert json_response(conn, 200)["data"]
  end
end
