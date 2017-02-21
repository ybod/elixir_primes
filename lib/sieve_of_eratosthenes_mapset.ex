defmodule Primes.SieveOfEratosthenes.MapSet do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses MapSet to store the list of integers for sieving.
  """

  import Integer, only: [is_odd: 1]

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
    odd_integers = Enum.filter(3..limit, &is_odd/1)
    integers_set = MapSet.new([2 | odd_integers])

    sieve(integers_set, 3, limit)
  end

  # Sieving
  # upper limit reached, get all primes that are left in the set as list
  defp sieve(integers_set, next_int, limit) when next_int * next_int > limit, do:
    MapSet.to_list(integers_set)

 # iterative algorithm step: if next_number from array is not marked, than it's prime
  defp sieve(integers_set, next_int, limit) do
    updated_integers_set =
      if MapSet.member?(integers_set, next_int) do
        remove_composites(integers_set, next_int * next_int, 2 * next_int, limit, [])
      else
        integers_set
      end

    sieve(updated_integers_set, next_int + 1, limit)
  end


  # Marking composite numbers (as false)
  defp remove_composites(integers_set, next, step, limit, composites) when next > limit do
    composites_set = MapSet.new(composites)
    MapSet.difference(integers_set, composites_set)
  end
end
