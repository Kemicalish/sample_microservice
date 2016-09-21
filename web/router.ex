defmodule UserManager.Router do
  use UserManager.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UserManager do
    pipe_through :api

    resources "/consumers", ConsumerController, only: [:index, :create, :delete]
    resources "/users", UserController 
    resources "/access", AccessController, only: [:create, :show]
  end
end
