defrecord Exroboarm.Client.State, device: nil

defmodule Exroboarm.Client do
  use ExActor
  alias Exroboarm.Commands

  definit device do
    device = :serial.start([speed: 115200, open: bitstring_to_list(device)])
    Exroboarm.Client.State.new(device: device)
  end

  [:hip, :shoulder, :elbow, :grip, :wrist] |> Enum.map(fn(which) ->
    defcall unquote(which)(angle, time), state: state do
      do_request(apply(Commands, unquote(which), [angle, time]), state)
    end
  end)

  defp do_request(request, state) do
    IO.inspect request
    send(state.device,  {:send, request})
    set_and_reply(state, :ok)
  end
end
