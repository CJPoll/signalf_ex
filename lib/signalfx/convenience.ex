defmodule Signalfx.Convenience do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
    end
  end

  defmacro adder(singular, key, pattern \\ quote(do: _)) do
    name = :"add_#{singular}"

    quote do
      def unquote(name)(%__MODULE__{} = struct, unquote(pattern) = child) do
        %__MODULE__{struct | unquote(key) => [child | struct.unquote(key)]}
      end
    end
  end
end
