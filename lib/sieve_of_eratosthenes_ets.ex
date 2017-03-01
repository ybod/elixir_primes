defmodule Primes.SieveOfEratosthenes.Ets do
  @moduledoc """
  Implements Sieve of Eratosthenes algorithm for finding all prime numbers up to the given limit.
  Uses Erlang ETS to store the list of odd integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit. Limit must be integer and larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.Ets.get_primes_list(10)
     [2, 3, 5, 7]
  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    odds = Sequence.get_odd(3, limit)
    odds_kv = Enum.map(odds, fn n -> {n, :prime} end)        # list of K/V pairs to insert them into ETS table

    ets = :ets.new(:numbers, [:ordered_set])
    :ets.insert(ets, odds_kv)

    sieve(ets, odds, limit)
  end


  # Sieving: all primes already found, no need to look furhter
  defp sieve(ets, [h | _], limit) when h * h > limit, do: get_primes(ets, :ets.first(ets), [2])

  # Check if the next odd number can be found as an ETS key.
  # If found - it's a prime number and we need to remove all multiples of this prime from ETS.
  defp sieve(ets, [h | t], limit) do
    if :ets.member(ets, h), do: delete_composite(ets, h, limit)

    sieve(ets, t, limit)
  end


  defp delete_composite(ets, num, limit) do
    Sequence.get(num * num, limit, 2 * num)
    |> Enum.each(fn n -> true = :ets.delete(ets, n) end)
  end


  defp get_primes(_, :"$end_of_table", primes), do: Enum.reverse(primes)
  defp get_primes(ets, key, primes),            do: get_primes(ets, :ets.next(ets, key), [key | primes])
end
