use Mix.Config

config :signalfx,
  realm: "us0",
  access_token: System.get_env("SIGNALFX_ACCESS_TOKEN")
