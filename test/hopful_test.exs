defmodule HopfulTest do
  use ExUnit.Case
  doctest Hopful

  test "greets the world" do
    assert Hopful.hello() == :world
  end
end
