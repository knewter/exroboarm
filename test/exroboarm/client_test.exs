defmodule Exroboarm.ClientTest do
  use ExUnit.Case

  test "creating a new Exroboarm client for a given device" do
    {:ok, pid} = Exroboarm.Client.start("/dev/pts/15")
    assert is_pid(pid)
  end
end
