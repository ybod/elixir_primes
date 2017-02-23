alias Primes.Timer

IO.puts("Sieve Of Eratosthenes: Erlang array")
{time, array_result} = Timer.run(Primes.SieveOfEratosthenes.Array, :get_primes_list, [15_485_863])
IO.puts("Time: #{time} sec.")
IO.inspect(array_result)

IO.puts("Sieve Of Eratosthenes: Elixir MapSet")
{time, mapset_result} = Timer.run(Primes.SieveOfEratosthenes.MapSet, :get_primes_list, [15_485_863])
IO.puts("Time: #{time} sec.")
IO.inspect(mapset_result)
