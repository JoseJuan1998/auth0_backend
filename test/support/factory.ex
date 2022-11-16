defmodule Auth0Backend.Factory do
  use ExMachina.Ecto, repo: Auth0Backend.Repo

  alias Auth0Backend.Account.User

  def user_factory do
    %User{
      # Tony 1, Tony 2, etc...
      first_name: sequence("Tony "),
      # Stark 1, Stark 2, etc...
      last_name: sequence("Stark "),
      email: sequence(:email, &"email_stark#{&1}@greenhouse.io"),
      phone: "1234567898"
    }
  end
end
