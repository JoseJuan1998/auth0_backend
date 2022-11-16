defmodule Auth0Backend.AccountFixtures do
  import Auth0Backend.Factory

  def users_fixture(_attrs \\ %{}) do
    %{
      user_0: insert(:user),
      user_1: insert(:user)
    }
  end
end
