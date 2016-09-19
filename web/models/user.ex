defmodule SampleMicroservice.User do
  use SampleMicroservice.Web, :model
  
  schema "users" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end
  
  @required_fields ~w( name )
  @required_registration_fields ~w( password )
  @optional_fields ~w( password_hash )

  @doc  """
  Creates a changeset based on the model and the params. If no params are provided, an invalid changeset is returned.
  """
  def changeset(model, params \\ :empty) do
    model
      |> cast(params, @required_fields, @optional_fields)
      |> validate_length(:name, min: 3, max: 20)
  end

  def registration_changeset(model, params \\ :empty) do
    model
      |> changeset(params)
      |> cast(params, @required_registration_fields, @optional_fields)
      |> validate_length(:password, min: 6, max: 20)
      |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{ password: pass }} -> 
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> 
        changeset
    end
  end

end
