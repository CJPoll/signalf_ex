defmodule Signalfx.DataPoints.Client do
  use HTTPoison.Base
  alias Signalfx.DataPoints.DataPoint

  def data_point(%DataPoint{} = data) do
    post("/datapoint", [data])
  end

  def data_points(data_points) do
    post("/datapoint", data_points)
  end

  # Callback Functions

  def process_request_body(data_points) do
    data_points
    |> Enum.group_by(fn %DataPoint{} = data -> data.type end, fn %DataPoint{} = data ->
      %{
        metric: data.metric,
        value: data.value,
        timestamp: DateTime.utc_now() |> DateTime.to_unix(:millisecond)
      }
    end)
    |> Jason.encode!()
  end

  def process_request_headers(_kw) do
    [
      {"X-SF-TOKEN", Application.get_env(:signalfx, :access_token)},
      {"Content-Type", "application/json"}
    ]
  end

  def process_url(path) do
    realm = Application.get_env(:signalfx, :realm)
    path = strip_leading_slash(path)

    uri = %URI{
      scheme: "https",
      host: "ingest.#{realm}.signalfx.com",
      path: "/v2/#{path}"
    }

    URI.to_string(uri)
  end

  defp strip_leading_slash("/" <> path), do: path
  defp strip_leading_slash(path), do: path
end
