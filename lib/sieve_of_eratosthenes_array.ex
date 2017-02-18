defmodule Primes.SieveOfEratosthenes.Array do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses Erlang array to store the list of numbers.
  """

  import Integer, only: [is_even: 1]

  @doc """
  Returns the list of the prime numbers up to the given limit.
  Limit must be integer larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.Array.get_primes_list(10)
     [2, 3, 5, 7]

  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit > 1 do
    integers_array = :array.new(size: limit + 1, fixed: true, default: true)
    integers_array = :array.set(0, false, integers_array)
    integers_array = :array.set(1, false, integers_array)
    integers_array = :array.set(2, true, integers_array)

    sieve(integers_array, 3, limit)
  end


  # Sieving
  # skip even number, go to the next one
  defp sieve(integers_array, next_int, limit) when is_even(next_int), do:
    sieve(integers_array, next_int + 1, limit)

  # upper limit reached, get all non marked integers from array which are primes
  defp sieve(integers_array, next_int, limit) when next_int * next_int > limit, do:
    get_primes(integers_array, 3, limit, [2])

 # iterative algorithm step: if next_number from array is not marked, than it's prime
  defp sieve(integers_array, next_int, limit) do
    updated_integers_array =
      if :array.get(next_int, integers_array) == true do
        mark_composites(integers_array, next_int * next_int, 2 * next_int, limit)
      else
        integers_array
      end

    sieve(updated_integers_array, next_int + 1, limit)
  end


  # Marking composite numbers (as false)
  # skip even number, go to the next one
  defp mark_composites(integers_array, next, step, limit) when is_even(next), do:
    mark_composites(integers_array, next + step, step, limit)

  # all composite numbers marked, returns updated array
  defp mark_composites(integers_array, next, _, limit) when next > limit, do:
    integers_array

  # iterative step: marking composite numbers (as false)
  defp mark_composites(integers_array, next, step, limit) do
    updated_integers_array = :array.set(next, false, integers_array)

    mark_composites(updated_integers_array, next + step, step, limit)
  end


  # Get all non marked (true) integers into list of prime numbers
  # skip even number, go to the next one
  defp get_primes(integers_array, i, limit, primes) when is_even(i), do:
    get_primes(integers_array, i + 1, limit, primes)

  # end of array reached, return list of primes
  defp get_primes(_, i, limit, primes) when i > limit, do:
    Enum.reverse(primes)

  # iterative step: put integer from an array into primes list if it's not marked as false
  defp get_primes(integers_array, i, limit, primes) do
      new_primes =
        if :array.get(i, integers_array), do: [i | primes], else: primes

      get_primes(integers_array, i + 1, limit, new_primes)
  end
end
