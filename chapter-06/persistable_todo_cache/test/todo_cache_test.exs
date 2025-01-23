defmodule TodoCacheTest do
  use ExUnit.Case
  
  test "server_process" do
    {:ok, cache} = TodoCache.start()
    bob_pid = TodoCache.server_process(cache, "bob")
    assert bob_pid != TodoCache.server_process(cache, "alice")
    assert bob_pid == TodoCache.server_process(cache, "bob")
  end
  
  test "to-do operations" do
    {:ok, cache} = TodoCache.start()
    alice = TodoCache.server_process(cache, "alice")
    TodoServer.add_entry(alice, %{date: ~D[2023-12-19], title: "Dentist"})
    entries = TodoServer.entries(alice, ~D[2023-12-19])
    assert [%{date: ~D[2023-12-19], title: "Dentist"}] = entries
  end
end