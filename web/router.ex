defmodule SampleMicroservice.Router do
  use SampleMicroservice.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SampleMicroservice do
    pipe_through :api
  end
end
