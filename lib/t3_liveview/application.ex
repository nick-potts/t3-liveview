defmodule T3Liveview.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      T3LiveviewWeb.Telemetry,
      T3Liveview.Repo,
      {DNSCluster, query: Application.get_env(:t3_liveview, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: T3Liveview.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: T3Liveview.Finch},
      # Start a worker by calling: T3Liveview.Worker.start_link(arg)
      # {T3Liveview.Worker, arg},
      # Start to serve requests, typically the last entry
      T3LiveviewWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: T3Liveview.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    T3LiveviewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
