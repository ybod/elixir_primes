defmodule Primes.SieveOfEratosthenes.Array do
  @moduledoc """
  Returns the list of the prime numbers up to the given Upper Limit

  ## Examples

     iex> Primes.SieveOfEratosthenes.Array.get_primes_list(10)
     [2, 3, 5, 7]

  """

  import Integer, only: [is_even: 1]

  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(upper_limit) when upper_limit > 1 do
    numbers_array = :array.new(size: upper_limit + 1, fixed: true, default: true)
    numbers_array = :array.set(0, false, numbers_array)
    numbers_array = :array.set(1, false, numbers_array)
    numbers_array = :array.set(2, true, numbers_array)

    sieve(numbers_array, 3, upper_limit)
  end

  # skip even numbers
  defp sieve(numbers_array, next_number, upper_limit) when is_even(next_number), do:
    sieve(numbers_array, next_number + 1, upper_limit)

  # upper limit reached, search array for non deleted numbers which are prime numbers
  defp sieve(numbers_array, next_number, upper_limit) when next_number * next_number > upper_limit, do:
    extract_primes(numbers_array, 2, upper_limit, [2])

 # regular algorithm step, if next_number from array is not deleted, than it's prime
  defp sieve(numbers_array, next_number, upper_limit) do
    updated_numbers_array =
      if :array.get(next_number, numbers_array) == true do
        deletion(numbers_array, next_number * next_number, next_number, upper_limit)
      else
        numbers_array
      end

    sieve(updated_numbers_array, next_number + 1, upper_limit)
  end

  # skip even numbers
  defp deletion(numbers_array, next, step, upper_limit) when is_even(next), do:
    deletion(numbers_array, next + step, step, upper_limit)

  defp deletion(numbers_array, next, _, upper_limit) when next > upper_limit, do:
    numbers_array

  defp deletion(numbers_array, next, step, upper_limit) do
      updated_numbers_array = :array.set(next, false, numbers_array)

      deletion(updated_numbers_array, next + step, step, upper_limit)
  end

  # skip even numbers
  defp extract_primes(numbers_array, i, upper_limit, primes) when is_even(i), do:
    extract_primes(numbers_array, i + 1, upper_limit, primes)

  defp extract_primes(_, i, upper_limit, primes) when i > upper_limit, do:
    Enum.reverse(primes)

  defp extract_primes(numbers_array, i, upper_limit, primes) do
      new_primes =
        if :array.get(i, numbers_array), do: [i | primes], else: primes

      extract_primes(numbers_array, i + 1, upper_limit, new_primes)
  end
end
