defmodule DeutchLernen.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DeutchLernenWeb.Telemetry,
      DeutchLernen.Repo,
      {DNSCluster, query: Application.get_env(:deutch_lernen, :dns_cluster_query) || :ignore},
      {Oban,
       AshOban.config(
         Application.fetch_env!(:deutch_lernen, :ash_domains),
         Application.fetch_env!(:deutch_lernen, Oban)
       )},
      {Phoenix.PubSub, name: DeutchLernen.PubSub},
      # Start a worker by calling: DeutchLernen.Worker.start_link(arg)
      # {DeutchLernen.Worker, arg},
      # Start to serve requests, typically the last entry
      DeutchLernenWeb.Endpoint,
      {Absinthe.Subscription, DeutchLernenWeb.Endpoint},
      AshGraphql.Subscription.Batcher
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DeutchLernen.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DeutchLernenWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
