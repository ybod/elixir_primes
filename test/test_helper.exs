ExUnit.start()
ExUnit.configure(exclude: [slow: true])

test_data = "test/test_data/"


million_primes_file = Path.join(test_data, "primes1.txt.gz")

million_primes_max = 15_485_863          # 15,485,863 is the first millionth prime number

million_primes =
  File.stream!(million_primes_file, [:compressed], :line)
  |> Stream.drop(1)
  |> Stream.flat_map(&String.split/1)
  |> Stream.map(&String.to_integer/1)
  |> Enum.to_list()

Application.put_env(:primes, :million_primes_max, million_primes_max)
Application.put_env(:primes, :million_primes, million_primes)


thousand_primes_file = Path.join(test_data, "1000.txt")

thousand_primes_max = 7919

thousand_primes =
  File.stream!(thousand_primes_file, [], :line)
  |> Stream.drop(3)
  |> Stream.flat_map(&String.split/1)
  |> Stream.map(&String.to_integer/1)
  |> Enum.to_list()

  Application.put_env(:primes, :thousand_primes_max, thousand_primes_max)
  Application.put_env(:primes, :thousand_primes, thousand_primes)
