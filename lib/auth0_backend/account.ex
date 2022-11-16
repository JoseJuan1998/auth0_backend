defmodule Auth0Backend.Account do
  alias Auth0Backend.Repo
  alias Auth0Backend.Account.User
  alias Auth0BackendWeb.Auth.Auth

  import Ecto.Query, warn: false

  def get_user(id) do
    Repo.get(User, id)
  end

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def auth0_id_update(user, params) do
    user
    |> User.add_auth0_id_changeset(params)
    |> Repo.update()
  end

  def validate_password(user, params) do
    user
    |> User.update_user_password(params)
    |> create_auth0_user(user)
  end

  defp create_auth0_user(%{valid?: false} = changeset, _) do
    changeset
  end

  defp create_auth0_user(%{valid?: true, changes: changes}, user = %User{}) do
    with {:ok, user_auth0} <- Auth.create_user("#{user.first_name} #{user.last_name}", user.email, changes.password),
    {:ok, updated_user} <- auth0_id_update(user, %{auth0_id: user_auth0["user_id"]}) do
      {:ok, updated_user}
    end
  end
end
