defmodule Auth0BackendWeb.Auth.Auth do
  def create_user(name, email, password) do
    {:ok, token} = get_token()

    body = %{
      name: name,
      email: email,
      connection: "Username-Password-Authentication",
      password: password,
      verify_email: true
    }

    user =
      Req.post!("https://code-green-house.us.auth0.com/api/v2/users",
        json: body,
        headers: [{"Authorization", "Bearer #{token}"}]
      ).body

    {:ok, user}
  end

  defp get_token() do
    body = %{
      audience: System.get_env("AUTH0_AUDIENCE"),
      client_id: System.get_env("AUTH0_CLIENT_ID"),
      client_secret: System.get_env("AUTH0_CLIENT_SECRET"),
      grant_type: System.get_env("AUTH0_GRANT_TYPE")
    }
    |> IO.inspect()

    response = Req.post!("https://code-green-house.us.auth0.com/oauth/token", json: body).body

    {:ok, response["access_token"]}
  end
end
