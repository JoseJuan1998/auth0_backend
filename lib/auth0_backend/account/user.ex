defmodule Auth0Backend.Account.User do
  use Ecto.Schema

  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime_usec]
  @type t :: %__MODULE__{}

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone, :string
    field :auth0_id, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :phone])
    |> validate_required([:first_name, :last_name, :email, :phone])
    |> unique_constraint([:email])
  end

  def add_auth0_id_changeset(user, attrs) do
    user
    |> cast(attrs, [:auth0_id])
    |> validate_required([:auth0_id])
  end

  def update_user_password(user, attrs) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password, :password_confirmation])
    |> validate_confirmation(:password)
  end
end
