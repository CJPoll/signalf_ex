defmodule Signalfx.MixProject do
  use Mix.Project

  def project do
    [
      app: :signalfx,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      module: {Signalfx.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.5.0"},
      {:jason, "~> 1.1.2"}
    ]
  end

  defp aliases do
    [compile: ["compile --warnings-as-errors"]]
  end
end
