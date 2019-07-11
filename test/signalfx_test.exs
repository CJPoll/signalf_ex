defmodule SignalfxTest do
  use ExUnit.Case
  doctest Signalfx

  test "greets the world" do
    assert Signalfx.hello() == :world
  end
end
