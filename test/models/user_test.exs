defmodule SampleMicroservice.UserTest do
  use SampleMicroservice.ModelCase

  alias SampleMicroservice.User

  @valid_attrs %{name: "valid_name12", password_hash: "SoSks92s_ZAs93kLinsi2osi12", password: "s3cr3t_Dud3"}
  @invalid_attrs %{name: "this name is too long for the correct name size omg", password: "1234"}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end
  
  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "registration changeset with valid attributes" do
    changeset = User.registration_changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "registration changeset with invalid attributes" do
    changeset = User.registration_changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end

