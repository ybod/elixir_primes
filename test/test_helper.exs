ExUnit.start()

max_prime_from_file = 15_485_863          # 15,485,863 is the first millionth prime number

primes_from_file =
  File.stream!("test/test_data/primes1.txt.gz", [:compressed], :line)
  |> Stream.drop(1)
  |> Stream.flat_map(&String.split/1)
  |> Stream.map(&String.to_integer/1)
  |> Enum.to_list()

Application.put_env(:primes, :primes_from_file, primes_from_file)
Application.put_env(:primes, :max_prime_from_file, max_prime_from_file)
