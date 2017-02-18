alias Primes.Timer

IO.puts("Sieve Of Eratosthenes: Erlang array")
{time, result} = Timer.run(Primes.SieveOfEratosthenes.Array, :get_primes_list, [15_485_863])
IO.puts("Time: #{time} sec.")
IO.inspect(result)
