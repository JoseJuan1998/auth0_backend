defmodule Auth0Backend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Auth0Backend.Repo,
      # Start the Telemetry supervisor
      Auth0BackendWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Auth0Backend.PubSub},
      # Start the Endpoint (http/https)
      Auth0BackendWeb.Endpoint
      # Start a worker by calling: Auth0Backend.Worker.start_link(arg)
      # {Auth0Backend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Auth0Backend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Auth0BackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
