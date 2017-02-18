defmodule Primes.SieveOfEratosthenes.Array.Test do
  use ExUnit.Case, async: true
  doctest Primes.SieveOfEratosthenes.Array

  setup_all _context do
    max_prime_from_file = Application.get_env(:primes, :max_prime_from_file)
    primes_from_file = Application.get_env(:primes, :primes_from_file)

    primes_calculated = Primes.SieveOfEratosthenes.Array.get_primes_list(max_prime_from_file)
    {:ok, primes_calculated: primes_calculated, primes_from_file: primes_from_file}
  end


  test "First million of primes", %{primes_calculated: primes_calculated, primes_from_file: primes_from_file} do
    assert primes_calculated == primes_from_file
  end
end
