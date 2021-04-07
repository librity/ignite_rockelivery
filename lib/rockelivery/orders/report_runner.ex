defmodule Rockelivery.Orders.ReportRunner do
  require Logger

  use GenServer

  alias Rockelivery.Orders.Report

  def start_link, do: GenServer.start_link(__MODULE__, %{})

  @impl true
  def init(state) do
    schedule_report()

    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    Logger.info("Generating report...")

    DateTime.utc_now()
    |> to_string()
    |> Report.create()

    schedule_report()

    {:noreply, state}
  end

  defp schedule_report do
    # delay = 1000 * 60 * 60
    delay = 1000 * 60
    Process.send_after(self(), :generate, delay)
  end
end
