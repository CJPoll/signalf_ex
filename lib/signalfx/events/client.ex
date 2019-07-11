defmodule Signalfx.Events.Client do
  use HTTPoison.Base
  alias Signalfx.Events.Event

  def event(%Event{} = event) do
    post("/event", [event])
  end

  def events(events) do
    post("/event", events)
  end

  # Callback Functions

  def process_request_body(data_points) do
    data_points
    |> Enum.map(fn %Event{} = data ->
      %{
        "category" => data.category,
        "eventType" => data.name,
        "timestamp" => DateTime.utc_now() |> DateTime.to_unix(:millisecond),
        "dimensions" =>
          data.dimensions
          |> Enum.map(&Signalfx.Dimension.to_tuple/1)
          |> Map.new(),
        "properties" =>
          data.properties
          |> Enum.map(&Signalfx.Property.to_tuple/1)
          |> Map.new()
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
