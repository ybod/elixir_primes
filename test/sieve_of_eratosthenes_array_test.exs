defmodule Primes.SieveOfEratosthenes.Array.Test do
  use ExUnit.Case, async: true
  doctest Primes.SieveOfEratosthenes.Array

  setup_all _context do
    million_primes_max = Application.get_env(:primes, :million_primes_max)
    million_primes = Application.get_env(:primes, :million_primes)

    thousand_primes_max = Application.get_env(:primes, :thousand_primes_max)
    thousand_primes = Application.get_env(:primes, :thousand_primes)

    {:ok, million_primes_max: million_primes_max, million_primes: million_primes,
      thousand_primes_max: thousand_primes_max, thousand_primes: thousand_primes}
  end

  test "Returns 2 for the smallest upper limit" do
    prime = Primes.SieveOfEratosthenes.Array.get_primes_list(2)

    assert(prime == [2])
  end

  test "First 1000 of primes", %{thousand_primes_max: thousand_primes_max, thousand_primes: thousand_primes}
  do
    calculated_primes = Primes.SieveOfEratosthenes.Array.get_primes_list(thousand_primes_max)

    assert(calculated_primes == thousand_primes)
  end

  @tag timeout: 90_000
  @tag :slow
  test "First million of primes", %{million_primes_max: million_primes_max, million_primes: million_primes}
  do
    calculated_primes = Primes.SieveOfEratosthenes.Array.get_primes_list(million_primes_max)

    assert(calculated_primes == million_primes)
  end
end
