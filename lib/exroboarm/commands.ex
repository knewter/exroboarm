defmodule Exroboarm.Commands do
  def translate(value, from, to) do
    in_from = 0
    in_to   = 180
    out_range = to - from
    in_range  = in_to - in_from
    in_val = value - in_from
    translated_value = (in_val/in_range) * out_range
    from + translated_value
  end

  def hip(angle, ms) do
    "#{movement(0, angle, 820, 2650)} T#{ms}\r\n"
  end

  def shoulder(angle, ms) do
    "#{movement(1, angle, 525, 2075)} #{movement(2, angle, 525, 2075)} T#{ms}\r\n"
  end

  def elbow(angle, ms) do
    "#{movement(3, angle, 560, 2100)} T#{ms}\r\n"
  end

  def wrist(angle, ms) do
    "#{movement(4, angle, 750, 2500)} T#{ms}\r\n"
  end

  def grip(angle, ms) do
    "#{movement(5, angle, 600, 2400)} T#{ms}\r\n"
  end

  defp movement(motor, angle, from, to) do
    "##{motor} P#{Float.ceil(translate(angle, from, to))}"
  end
end
