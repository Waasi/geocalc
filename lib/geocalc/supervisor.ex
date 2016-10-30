defmodule Geocalc.Supervisor do
  @moduledoc false

  alias Geocalc.Calculator

  def start_link(count) do
    Supervisor.start_link(__MODULE__, count, name: __MODULE__)
  end

  def init(count) do
    import Supervisor.Spec

    children = Enum.map(1..count, fn (n) -> worker(Calculator, [], id: n) end)

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, max_restarts: 1_000, max_seconds: 1]
    supervise(children, opts)
  end
end