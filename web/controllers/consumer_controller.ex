defmodule SampleMicroservice.ConsumerController do
  use SampleMicroservice.Web, :controller

  alias SampleMicroservice.Consumer
  alias SampleMicroservice.KongAdminRepo

  plug :scrub_params, "consumer" when action in [:create, :update]

  def index(conn, _params) do
    consumers = KongAdminRepo.all(Consumer) 
    render(conn, "index.json", consumers: consumers)
  end

  def create(conn, %{"consumer" => %{"username" => username}}) do
    
  end
end 
