defmodule Primes.SieveOfEratosthenes.List do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses MapSet to store the list of integers for sieving.
  """

  import Integer, only: [is_odd: 1]

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
    :lists.seq(3, limit, 2)
    |> sieve(limit, [2])
  end

  # Sieving: limit reached, get all numbers that are left in the set - this numbers is primes
  defp sieve([], _, primes_list), do: Enum.reverse(primes_list)
  
  # Sieving: check if the next prime candidate integer is in set,
  # if it is - than remove all composites for this prime
  defp sieve([h | t], limit, primes_list) do
    new_integers_list = t -- :lists.seq(h * h, limit, 2 * h)

    sieve(new_integers_list, limit, [h | primes_list])
  end

  defp get_odd_integers(first, limit) when is_odd(first), do: :lists.seq(first, limit, 2)
  
  defp get_composite(number, step, limit), do: :lists.seq(number, limit, step)
end
