defmodule UserManager.ConsumerController do
  use UserManager.Web, :controller

  alias UserManager.Consumer
  alias UserManager.KongAdminRepo

  plug :scrub_params, "consumer" when action in [:create, :update]

  def index(conn, _params) do
    consumers = KongAdminRepo.all(Consumer) 
    render(conn, "index.json", consumers: consumers)
  end

  def create(conn, consumer = %{"consumer" => %{"username" => username}}) do
    case result = KongAdminRepo.insert(Consumer, {:form, [{"username", username}]}) do
      {:ok, consumer}    -> 
      conn
        |> put_status(:created)
        |> render("show.json", consumer: consumer) 
      {:error, error} -> 
      conn
       |> put_status(:unprocessable_entity)
       |> render(UserManager.ErrorView, "422.json") 
    end
  end

  def delete(conn, %{"id" => username}) do
    case result = KongAdminRepo.delete(Consumer, username) do
      {:ok, _deleted}   -> 
        conn
          |> put_status(:no_content)
      {:error, error}   ->
        conn
          |> put_status(:not_found)
          |> render(UserManager.ErrorView, "404.json")
    end
  end 
end 
