defmodule Primes.SieveOfEratosthenes.Map do
  @moduledoc """
  Implements Sieve of Eratosthenes algorithm for finding all prime numbers up to the given limit.
  Uses Elixir Map to store the list of odd integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit.
  Limit must be integer and larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.Map.get_primes_list(10)
     [2, 3, 5, 7]
  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    odds = Sequence.get_odd(3, limit)
    map = Map.new(odds, &{&1, :prime})

    sieve(odds, map, limit)
  end

  # Sieving: all primes already found, no need to look furhter
  defp sieve([h | _], map, limit) when h * h > limit, do: get_primes(map)

  # Check if the next odd number can be found as a Map key.
  # If found - it's a prime number and we need to remove all multiples of this prime from Map.
  defp sieve([h | t], map, limit) do
    new_map =
      if Map.has_key?(map, h), do: delete_composite(h, map, limit), else: map

    sieve(t, new_map, limit)
  end


  defp get_primes(map) do
    primes =
      Map.keys(map)
      |> Enum.sort()

    [2 | primes]
  end


  defp delete_composite(first, map, limit) do
    composite_nums = Sequence.get(first * first, limit, 2 * first)
    Map.drop(map, composite_nums)
  end
end
