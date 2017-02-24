alias Primes.Timer

#max_prime = 15_485_863   # one million primes
max_prime = 32_452_843  # two millions primes

IO.puts("Sieve Of Eratosthenes: Erlang array")
{time, array_result} = Timer.run(Primes.SieveOfEratosthenes.Array, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(array_result)

IO.puts("Sieve Of Eratosthenes: Elixir MapSet")
{time, mapset_result} = Timer.run(Primes.SieveOfEratosthenes.MapSet, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(mapset_result)

IO.puts("Sieve Of Eratosthenes: Elixir List")
{time, list_result} = Timer.run(Primes.SieveOfEratosthenes.List, :get_primes_list, [max_prime])
IO.puts("Time: #{time} sec.")
IO.inspect(list_result)
