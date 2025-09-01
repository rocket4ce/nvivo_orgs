defmodule NvivoOrgs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NvivoOrgsWeb.Telemetry,
      NvivoOrgs.Repo,
      {DNSCluster, query: Application.get_env(:nvivo_orgs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NvivoOrgs.PubSub},
      # Start a worker by calling: NvivoOrgs.Worker.start_link(arg)
      # {NvivoOrgs.Worker, arg},
      # Start to serve requests, typically the last entry
      NvivoOrgsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NvivoOrgs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NvivoOrgsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
