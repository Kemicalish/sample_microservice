defmodule UserManager.AccessView do
  use UserManager.Web, :view

  def render("index.json", %{accesses: accesses}) do
    %{data: render_many(accesses, UserManager.AccessView, "access.json")}
  end

  def render("show.json", %{access: access}) do
    %{data: render_one(access, UserManager.AccessView, "access.json")}
  end

  def render("access.json", %{access: access}) do
    %{
      refresh_token: access.refresh_token,
      token_type: access.token_type,
      access_token: access.access_token,
      expires_in: access.expires_in
    }
  end
end
