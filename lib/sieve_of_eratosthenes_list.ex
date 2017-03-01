defmodule Primes.SieveOfEratosthenes.List do
  @moduledoc """
  Implements Sieve of Eratosthenes algorithm for finding all prime numbers up to the given limit.
  Uses Elixir List to store the list of integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit. Limit must be integer and larger than 1.
  ## Examples

     iex> Primes.SieveOfEratosthenes.List.get_primes_list(10)
     [2, 3, 5, 7]

  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    list = Sequence.get_odd(3, limit)

    sieve(list, limit, [2])
  end

  # Sieving: all primes already found, no need to look furhter
  defp sieve([p], limit, primes), do: Enum.reverse([p | primes])

  # Sieving: get next prime from the head ot the list and remove all composite numbers from the tail
  defp sieve([h | t], limit, primes) do
    new_list = t -- Sequence.get(h * h, limit, 2 * h)
    
    sieve(new_list, limit, [h | primes])
  end
end
