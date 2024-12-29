defmodule ElixirGqlapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirGqlappWeb.Telemetry,
      ElixirGqlapp.Repo,
      {DNSCluster, query: Application.get_env(:elixir_gqlapp, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirGqlapp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirGqlapp.Finch},
      # Start a worker by calling: ElixirGqlapp.Worker.start_link(arg)
      # {ElixirGqlapp.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirGqlappWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirGqlapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirGqlappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
