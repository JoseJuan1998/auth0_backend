defmodule Auth0BackendWeb.UserController do
  use Auth0BackendWeb, :controller

  alias Auth0Backend.Account
  alias Auth0BackendSystem.Mailing

  def create_user(conn, params) do
    with {:ok, user} <- Account.create_user(params),
         {:ok, _email} <- Mailing.send_verification_email(user) do
      conn
      |> put_status(201)
      |> text("Created")
    else
      {:error, _error} ->
        conn
        |> put_status(400)
        |> text("Bad request")
    end
  end

  def create_password(conn, %{"token" => token} = params) do
    with {:ok, user_from_token} <-
           Phoenix.Token.verify(Auth0BackendWeb.Endpoint, "user confirmation token", token,
             max_age: 60 * 60 * 24
           ),
         user <- Account.get_user(user_from_token.id),
         {:ok, _updated_user} <- Account.validate_password(user, params) do
      conn
      |> put_status(200)
      |> text("User confirmed")
    else
      {:error, _error} ->
        conn
        |> put_status(400)
        |> text("Bad request")

      %Ecto.Changeset{} ->
        conn
        |> put_status(400)
        |> text("Bad request")
    end
  end

  def create_password(conn, _params) do
    conn
    |> put_status(400)
    |> text("Bad request")
  end
end
