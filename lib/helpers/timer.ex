defmodule Primes.Helper.Timer do
  def run(module, func, params \\ []) when is_atom(module) and is_atom(func) and is_list(params) do
    parent = self()

    spawn_link fn ->
      send(parent, { :tc, :timer.tc(module, func, params) })
    end

    receive do
      { :tc, { timer, res } } -> { timer / 1_000_000, res }
    end
  end
end
