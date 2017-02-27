defmodule Primes.SieveOfEratosthenes.List do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses MapSet to store the list of integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit.
  Limit must be integer larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.List.get_primes_list(10)
     [2, 3, 5, 7]

  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    Sequence.get_odd(3, limit)
    |> sieve(limit, [2])
  end

  # Sieving: limit reached, get all numbers that are left in the set - this numbers is primes
  defp sieve([], _, primes_list),  do: Enum.reverse(primes_list)
  defp sieve([p], _, primes_list), do: Enum.reverse([p | primes_list])

  # Sieving: check if the next prime candidate integer is in set,
  # if it is - than remove all composites for this prime
  defp sieve([h | t], limit, primes_list) do
    new_integers_list = t --  Sequence.get(h * h, limit, 2 * h)   # remove composite numbers for the current prime (h) from the rest of the list (t)

    sieve(new_integers_list, limit, [h | primes_list])
  end
end
