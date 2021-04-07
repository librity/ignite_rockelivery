defmodule Rockelivery.Orders.ReportRunner do
  require Logger

  use GenServer

  alias Rockelivery.Orders.Report

  @delay 1000 * 60 * 60 * 24

  def start_link(initial_state \\ %{}), do: GenServer.start_link(__MODULE__, initial_state)

  @impl true
  def init(state) do
    Logger.info("Orders report runner initialized!")
    schedule_report()

    {:ok, state}
  end

  @impl true
  def handle_info(:generate, state) do
    Logger.info("Generating orders report...")

    generate_filename()
    |> Report.create()

    schedule_report()

    {:noreply, state}
  end

  defp schedule_report do
    Process.send_after(self(), :generate, @delay)
  end

  defp generate_filename do
    date =
      NaiveDateTime.local_now()
      |> NaiveDateTime.to_iso8601()

    "orders_report_#{date}"
  end
end
