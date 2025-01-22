defmodule TodoServer do
  use GenServer

  def start do
    GenServer.start(TodoServer, nil)
  end

  def add_entry(todo_server, new_entry) do
    GenServer.cast(todo_server, {:add_entry, new_entry})
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end


  def init(_) do
    {:ok, TodoList.new}
  end

  def handle_cast({:add_entry, new_entry}, todo_list) do
    new_state = TodoList.add_entry(todo_list, new_entry)
    {:noreply, new_state}
  end

  def handle_call({:entries, date}, _, todo_list) do
    {
      :reply,
      TodoList.entries(todo_list, date),
      todo_list
    }
  end
end