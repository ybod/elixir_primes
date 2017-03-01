alias Primes.Helper.Timer

#max_prime = 100_000
#max_prime = 15_485_863   # one million primes
max_prime = 32_452_843  # two millions primes


IO.puts("\nSieve Of Eratosthenes: Erlang array")
{time, array_result} = Timer.run(Primes.SieveOfEratosthenes.Array, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(array_result)

IO.puts("\nSieve Of Eratosthenes: Elixir MapSet")
{time, mapset_result} = Timer.run(Primes.SieveOfEratosthenes.MapSet, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(mapset_result)

# IO.puts("\nSieve Of Eratosthenes: Elixir List")
# {time, list_result} = Timer.run(Primes.SieveOfEratosthenes.List, :get_primes_list, [max_prime])
# IO.puts("Time: #{time} sec.")
# IO.inspect(list_result)

IO.puts("\nSieve Of Eratosthenes: Erlang ETS")
{time, est_result} = Timer.run(Primes.SieveOfEratosthenes.Ets, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(est_result)

IO.puts("\nSieve Of Eratosthenes: Elixir Map")
{time, map_result} = Timer.run(Primes.SieveOfEratosthenes.Map, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(map_result)


results = array_result == mapset_result and mapset_result == est_result and est_result == map_result
IO.puts("\nResults equal: #{results}")
