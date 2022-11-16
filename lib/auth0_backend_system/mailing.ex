defmodule Auth0BackendSystem.Mailing do
  use Bamboo.Phoenix, view: Auth0BackendWeb.EmailView

  import Bamboo.Email

  alias Auth0Backend.Account.User

  def send_verification_email(%User{} = user) do
    token =
      Phoenix.Token.sign(
        Auth0BackendWeb.Endpoint,
        "user confirmation token",
        Map.from_struct(user)
      )

    assigns = %{
      user: user,
      url: "http://localhost:5173/create_password?token=#{token}"
    }

    new_email()
    |> to({"#{user.first_name} #{user.last_name}", user.email})
    |> from("green_house@cordage.io")
    |> subject("Verify your account")
    |> render("verification_email.html", assigns)
    |> Auth0BackendSystem.Mailer.deliver_later()
  end
end
