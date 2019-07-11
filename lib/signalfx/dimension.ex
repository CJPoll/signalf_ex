defmodule Signalfx.Dimension do
  defstruct [:key, :value]

  def new(key, value) do
    %__MODULE__{key: key, value: value}
  end

  def to_tuple(%__MODULE__{key: key, value: value}) do
    {key, value}
  end
end
