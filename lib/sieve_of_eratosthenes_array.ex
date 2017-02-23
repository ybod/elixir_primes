defmodule Primes.SieveOfEratosthenes.Array do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses Erlang array to store the list of integers for sieving.
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
    get_initial_array(limit)
    |> sieve(3, limit)
  end


  # Sieving: limit reached, scan array to retrieve primes
  defp sieve(integers_array, next, limit) when next * next > limit, do: get_primes(integers_array)
    
  # Sieving: check if the next array item that corresponds to a number is true (prime),
  # if it is - than mark all composites for this prime as false
  defp sieve(integers_array, next, limit) do
    updated_integers_array =
      if :array.get(next, integers_array) == true do
        mark_composites(integers_array, next * next, 2 * next, limit)
      else
        integers_array
      end

    sieve(updated_integers_array, next + 1, limit)
  end


  # Marking composite numbers (as false)
  defp mark_composites(array, next, _, limit) when next > limit, do: array

  defp mark_composites(array, next, step, limit) do
    array = :array.set(next, false, array)
    mark_composites(array, next + step, step, limit)
  end

  # Initial array of all integers to sieve
  defp get_initial_array(limit) do
    array = :array.new(size: limit + 1, fixed: true, default: true)
    array = :array.set(0, false, array)
    array = :array.set(1, false, array)
    array = :array.set(2, true, array)
    array = mark_even(array, 4, limit)
    
    array
  end

  # Marking even integers as false
  defp mark_even(array, next, limit) when next > limit, do: array
  
  defp mark_even(array, next, limit) when is_even(next) do
    array = :array.set(next, false, array)
    mark_even(array, next + 2, limit)
  end

  # Get prime numbers (true) from array
  defp get_primes(array) do
    :array.foldr(
      fn (i, val, acc) -> 
        if val == true, do: [i | acc], else: acc
      end, [], array)
  end
end
