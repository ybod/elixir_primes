defmodule Primes.SieveOfEratosthenes.MapSet do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses MapSet to store the list of integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit.
  Limit must be integer larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.MapSet.get_primes_list(10)
     [2, 3, 5, 7]

  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    odd_integers = Sequence.get_odd(3, limit)
    integers_set = MapSet.new([2 | odd_integers])

    sieve(integers_set, 3, limit)
  end

  # Sieving: limit reached, get all numbers that are left in the set - this numbers is primes
  defp sieve(integers_set, next, limit) when next * next > limit do
    MapSet.to_list(integers_set)
    |> Enum.sort()
  end

  # Sieving: check if the next prime candidate integer is in set,
  # if it is - than remove all composites for this prime
  defp sieve(integers_set, next, limit) do
    new_integers_set =
      if MapSet.member?(integers_set, next) do
        composites =
          Sequence.get(next * next, limit, 2 * next)
          |> MapSet.new()

        MapSet.difference(integers_set, composites)
      else
        integers_set
      end

    sieve(new_integers_set, next + 1, limit)
  end
end
