defmodule Signalfx.Events.Event do
  defstruct [:category, :name, dimensions: [], properties: []]

  use Signalfx.Convenience

  alias Signalfx.{Dimension, Property}

  @categories [
    :alert,
    :audit,
    :collected,
    :exception,
    :job,
    :service_discovery,
    :user_defined
  ]

  adder(:dimension, :dimensions, %Dimension{})
  adder(:property, :properties, %Property{})

  def new(name, dimensions \\ [], properties \\ [], category \\ :user_defined)
      when category in @categories do
    %__MODULE__{
      category: category,
      name: name,
      dimensions: dimensions,
      properties: properties
    }
  end
end
