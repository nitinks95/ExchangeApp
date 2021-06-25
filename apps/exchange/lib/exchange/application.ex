defmodule Exchange.Console.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: Exchange.Console.PubSub},
      {Exchange.Stats.Caller, []},
      {Exchange.Aggregation, []},
      {Exchange.Connection, ["BTC-USD"]}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Exchange.Console.Supervisor)
  end
end
