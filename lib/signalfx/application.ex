defmodule Signalfx.Application do
  use Application

  def start(_, _) do
    children = []
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
