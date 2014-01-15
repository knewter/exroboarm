defrecord Exroboarm.State, client: nil, wrist: 90

defmodule Exroboarm.TcpServer do
  def listen(port) do
    IO.puts "preparing roboarm"
    {:ok, pid} = Exroboarm.Client.start("/dev/ttyUSB0")
    IO.puts "listening on port #{port}"
    tcp_options = [:binary, {:packet, 0}, {:active, false}]
    {:ok, listening_socket} = :gen_tcp.listen(port, tcp_options)
    do_accept(listening_socket, Exroboarm.State[client: pid])
  end

  def do_accept(listening_socket, state) do
    {:ok, socket} = :gen_tcp.accept(listening_socket)
    update_wrist(state, 0)
    do_listen(socket, state)
  end

  def do_listen(socket, state) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        IO.puts "Got some data! #{data}"
        state = case data do
          "1\n" -> update_wrist(state, 1)
          "-1\n" -> update_wrist(state, -1)
          _ -> :ok
        end
        #:gen_tcp.send(socket, "Roger, wilco!\n")
        do_listen(socket, state)
      {:error, :closed} ->
        IO.puts "The client closed the connection..."
    end
  end

  def update_wrist(state, direction) do
    new_state = state.wrist(state.wrist + direction)
    Exroboarm.Client.wrist(state.client, new_state.wrist, 1000)
    new_state
  end
end
