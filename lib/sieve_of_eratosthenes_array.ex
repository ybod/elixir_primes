defmodule Primes.SieveOfEratosthenes.Array do
  @moduledoc """
  Implements Sieve of Eratosthenes algorithm for finding all prime numbers up to the given limit.
  Uses Erlang Array to store the list of integers for sieving.
  """

  import Integer, only: [is_odd: 1]

  @doc """
  Returns the list of the prime numbers up to the given limit. Limit must be integer and larger than 1.
  ## Examples

     iex> Primes.SieveOfEratosthenes.Array.get_primes_list(10)
     [2, 3, 5, 7]
  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit > 1 do
    get_array(limit)
    |> sieve(3, limit)
  end


  # Sieving: all primes already found, no need to look furhter
  defp sieve(array, odd, limit) when odd * odd > limit do
    :array.sparse_foldr(fn(i, _val, acc) -> [i | acc] end, [], array)
  end

  # Check if the next odd number (array element index) corresponds to the true element inside array.
  # If true - it's a prime number and we need to mark all multiples of this prime as false in array.
  defp sieve(array, odd, limit) do
    new_array =
      if :array.get(odd, array) == true do
        mark_composite(array, odd * odd, 2 * odd, limit)
      else
        array
      end

    sieve(new_array, odd + 2, limit)
  end


  # Marking composite numbers (as false)
  defp mark_composite(array, next, step, limit) when next > limit, do: array

  defp mark_composite(array, next, step, limit) do
    array = :array.set(next, false, array)
    mark_composite(array, next + step, step, limit)
  end


  # Array initialization
  defp get_array(limit) do
    array = :array.new(size: limit + 1, fixed: true, default: false)
    array = :array.map(fn(i, _val) -> is_odd(i) end, array)
    array = :array.set(1, false, array)
    array = :array.set(2, true, array)

    array
  end
end
