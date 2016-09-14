defmodule SampleMicroservice.Router do
  use SampleMicroservice.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SampleMicroservice do
    pipe_through :api

    resources "/consumers", ConsumerController, only: [:index, :create]
  end
end
