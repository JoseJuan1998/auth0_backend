defmodule Auth0Backed.Auth0Mocks do
  def auth0_get_token_success() do
    %{
      body: %{
        "access_token" => "58457fe6b27..."
      }
    }
  end

  def auth0_create_user_success() do
    %{
      body: %{
        "user_id" => "58457fe6b27...",
        "email_verified" => true,
        "email" => "test@cordage.io"
      }
    }
  end
end
