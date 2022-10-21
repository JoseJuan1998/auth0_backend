defmodule Auth0Backend.Repo do
  use Ecto.Repo,
    otp_app: :auth0_backend,
    adapter: Ecto.Adapters.Postgres
end
