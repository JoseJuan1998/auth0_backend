defmodule Auth0Backend.AccountTest do
  use Auth0Backend.DataCase, async: true

  import Auth0Backend.AccountFixtures
  import Auth0Backed.Auth0Mocks
  import Mock

  alias Auth0Backend.Account
  alias Auth0Backend.Account.User

  describe "[unit] get_user/1" do
    setup [:users_fixture]

    @tag :unit
    test "returns a user by id", context do
      id = context.user_0.id

      result = Account.get_user(id)

      assert not is_nil(result)
    end

    @tag :unit
    test "returns nil when id is wrong" do
      result = Account.get_user(Ecto.UUID.generate())

      assert is_nil(result)
    end
  end

  describe "[unit] create_user/1" do
    @tag :unit
    test "returns a user created" do
      params = params_for(:user)

      result = Account.create_user(params)

      assert {:ok, %User{}} = result
    end

    @tag :unit
    test "returs error changeset when params empty" do
      params = %{}

      result = Account.create_user(params)

      assert {:error, %Ecto.Changeset{}} = result
    end
  end

  describe "[unit] validate_password/2" do
    setup [:users_fixture]

    @tag :unit
    test "returns an updated user", context do
      with_mocks([
        {
          Req,
          [],
          [
            post!: fn
              "https://code-green-house.us.auth0.com/oauth/token", _body ->
                auth0_get_token_success()

              "https://code-green-house.us.auth0.com/api/v2/users", _body ->
                auth0_create_user_success()
              end
          ]
        }
      ]) do
        params = %{
          "password" => "Qwerty2023@",
          "password_confirmation" => "Qwerty2023@"
        }
        result = Account.validate_password(context.user_0, params)

        assert {:ok, %User{}} = result
      end
    end
  end
end
