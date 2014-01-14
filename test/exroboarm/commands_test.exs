defmodule Exroboarm.CommandsTest do
  use ExUnit.Case
  alias Exroboarm.Commands, as: C

  test "translation" do
    assert C.translate(180, 0, 100) == 100
    assert C.translate(0, 0, 100)   == 0
    assert C.translate(90, 0, 100)  == 50
    assert C.translate(180, 100, 200) == 200
    assert C.translate(0, 100, 200)   == 100
    assert C.translate(90, 100, 200)  == 150
  end

  test "hip movement" do
    assert C.hip(180, 100) == "#0 P2650 T100\r\n"
  end

  test "shoulder movement" do
    assert C.shoulder(180, 100) == "#1 P2075 #2 P2075 T100\r\n"
  end

  test "elbow movement" do
    assert C.elbow(180, 100) == "#3 P2100 T100\r\n"
  end

  test "wrist movement" do
    assert C.wrist(180, 100) == "#4 P2500 T100\r\n"
  end

  test "grip movement" do
    assert C.grip(180, 100) == "#5 P2400 T100\r\n"
  end
end
