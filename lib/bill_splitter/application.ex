defmodule BillSplitter.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: BillSplitter.Router, port: 4000}
    ]

    opts = [
      strategy: :one_for_one,
      name: BillSplitter.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
