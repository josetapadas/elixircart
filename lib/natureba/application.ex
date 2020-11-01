defmodule Natureba.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Natureba.Repo,
      # Start the Telemetry supervisor
      NaturebaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Natureba.PubSub},
      # Start the Endpoint (http/https)
      NaturebaWeb.Endpoint,
      # Start a worker by calling: Natureba.Worker.start_link(arg)
      # {Natureba.Worker, arg}
      Natureba.Workers.CartSupervisor,
      { Registry, [keys: :unique, name: :cart_registry] }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Natureba.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NaturebaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
