defmodule Auth0BackendWeb.UserControllerTest do
  use Auth0BackendWeb.ConnCase

  describe "[ctrl] create_user" do
    @tag :controller
    test "return user creates succesfully", %{conn: conn} do
      params = params_for(:user)

      response =
        conn
        |> post(Routes.user_path(conn, :create_user), params)
        |> response(201)

      assert "Created" == response
    end
  end
end
