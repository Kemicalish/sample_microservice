defmodule SampleMicroservice.UserView do
  use SampleMicroservice.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, SampleMicroservice.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, SampleMicroservice.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
    id: user.id,
    name: user.name,
    password_hash: user.password_hash
    }
  end

end
