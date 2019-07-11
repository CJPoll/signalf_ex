defmodule Signalfx.DataPoints.DataPoint do
  use Signalfx.Convenience
  alias Signalfx.Dimension

  defstruct [:metric, :value, :type, dimensions: []]

  adder(:dimension, :dimensions, %Dimension{})

  def new(metric, value, type)
      when type in [:counter, :cumulative_counter, :gauge] and
             is_binary(metric) and
             is_number(value) do
    %__MODULE__{metric: metric, value: value, type: type}
  end
end
