defmodule UserManager.UserView do
  use UserManager.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserManager.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserManager.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
    id: user.id,
    name: user.name,
    password_hash: user.password_hash
    }
  end

end
