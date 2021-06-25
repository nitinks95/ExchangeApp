defmodule Exchange.ConsoleWeb.ConsoleLive do
  use Exchange.ConsoleWeb, :live_view

  def mount(_params, _session, socket) do
    Exchange.Stats.Caller.subscribe()

    counts =
      %{date: nil}
      |> Map.put(:avg_buy, nil)
      |> Map.put(:avg_sell, nil)
      |> Map.put(:max_buy, nil)
      |> Map.put(:max_sell, nil)

    {:ok, fetch(socket, counts)}
  end

  def handle_info({Exchange.Stats.Caller, [stats: :updated], stats}, socket) do
    {:noreply, fetch(socket, stats)}
  end

  def render(assigns) do
    ~L"""
    Live Update of BITCOIN from coinbase <br>
    Timestamp: <%= @stats.date %> <br>
    <br>
    Average Buying price: <%= @stats.avg_buy %> <br>
    Average Selling price: <%= @stats.avg_sell %> <br>
    Maximum Buying Bid price: <%= @stats.max_buy %> <br>
    Maximum Selling Bid price: <%= @stats.max_sell %> <br>
    """
  end

  defp fetch(socket, stats) do
    assign(socket, stats: stats)
  end
end
