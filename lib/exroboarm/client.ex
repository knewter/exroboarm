defrecord Exroboarm.Client.State, device: nil

defmodule Exroboarm.Client do
  use ExActor
  alias Exroboarm.Commands

  definit device do
    device = :serial.start([speed: 115200, open: bitstring_to_list(device)])
    Exroboarm.Client.State.new(device: device)
  end

  defcall hip(angle, time), state: state do
    do_request(Commands.hip(angle, time), state)
  end

  defcall shoulder(angle, time), state: state do
    do_request(Commands.shoulder(angle, time), state)
  end

  defcall elbow(angle, time), state: state do
    do_request(Commands.elbow(angle, time), state)
  end

  defcall grip(angle, time), state: state do
    do_request(Commands.grip(angle, time), state)
  end

  defcall wrist(angle, time), state: state do
    do_request(Commands.wrist(angle, time), state)
  end

  defp do_request(request, state) do
    IO.inspect request
    state.device <- {:send, request}
    set_and_reply(state, :ok)
  end
end
