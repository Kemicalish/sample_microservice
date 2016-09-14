defmodule SampleMicroservice.ConsumerController do
  use SampleMicroservice.Web, :controller

  alias SampleMicroservice.Consumer
  alias SampleMicroservice.KongAdminRepo

  plug :scrub_params, "consumer" when action in [:create, :update]

  def index(conn, _params) do
    consumers = KongAdminRepo.all(Consumer) 
    render(conn, "index.json", consumers: consumers)
  end

  def create(conn, consumer = %{"consumer" => %{"username" => username}}) do
    IO.inspect("Try create")
    IO.inspect consumer
    IO.inspect username
    case result = KongAdminRepo.insert(Consumer, %{username: username}) do
      {:ok, consumer}    -> 
        conn
          |> put_status(:created)
          |> render("show.json", consumer: consumer) 
      {:error, error} -> 
        conn
          |> put_status(:unprocessable_entity)
          |> render(SampleMicroservice.ErrorView, "422.json") 
      _ ->
        IO.inspect result
    end
  end
end 
