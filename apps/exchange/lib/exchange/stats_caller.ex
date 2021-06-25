defmodule Exchange.Stats.Caller do
  use GenServer

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Exchange.Console.PubSub, @topic)
  end

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: __MODULE__)

  def init(_) do
    start()
    {:ok, %{}}
  end

  def handle_info(:warm, _) do
    {:ok, now} = DateTime.now("Etc/UTC")

    counts =
      Exchange.Stats.get_stats()
      |> Map.put(:date, now)

    broadcast_change(counts, stats: :updated)

    start()
    {:noreply, counts}
  end

  def start, do: Process.send_after(self(), :warm, 5000)
  # restart process after 5sec

  defp broadcast_change(present, event) do
    Phoenix.PubSub.broadcast(Exchange.Console.PubSub, @topic, {__MODULE__, event, present})
  end
end
