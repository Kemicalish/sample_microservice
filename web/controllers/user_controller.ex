defmodule UserManager.UserController do
  use UserManager.Web, :controller

  alias UserManager.KongRepo
  alias UserManager.KongAdminRepo
  alias UserManager.User
  alias UserManager.Consumer

  plug :scrub_params, "user" when action in [:create, :update]

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users) 
  end

  def create(conn, %{"user" => user_params = %{"name" => name, "password" => password } }) do
    changeset = User.registration_changeset(%User{}, user_params)
    
    with {:ok, user} <- Repo.insert(changeset),
    {:ok, consumer} <- KongAdminRepo.insert(Consumer, {:form, [{"username", name}]}) do conn
      |> put_status(:created)
      |> put_resp_header("location", user_path(conn, :show, user))
      |> render("show.json", user: user)
    else
      {:error, %{request: %Dayron.Request{body: body}}} ->
        conn
          |> put_status(:conflict)
          |> render(UserManager.ErrorView, "409.json") 
      {:error, changeset} ->
        conn 
          |> put_status(:unprocessable_entity)
          |> render(UserManager.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
          |> put_status(:unprocessable_entity)
          |> render(UserManager.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

end
