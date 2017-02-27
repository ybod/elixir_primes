defmodule Primes.SieveOfEratosthenes.Ets do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses MapSet to store the list of integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit.
  Limit must be integer larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.Ets.get_primes_list(10)
     [2, 3, 5, 7]

  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    odds =
      Sequence.get_odd(3, limit)
      |> Enum.map(fn n -> {n, true} end)

    ets = :ets.new(:numbers, [:ordered_set])
    :ets.insert(ets, odds)

    sieve(ets, :ets.first(ets), limit)
  end


  defp sieve(ets, :end_of_table, _limit),             do: get_primes(ets)

  defp sieve(ets, num, limit) when num * num > limit, do: get_primes(ets)

  defp sieve(ets, num, limit) do
    [{^num, is_prime}] = :ets.lookup(ets, num)
    if is_prime, do: mark_composite(ets, num, limit)

    sieve(ets, :ets.next(ets, num), limit)
  end


  defp mark_composite(ets, num, limit) do
    Sequence.get(num * num, limit, 2 * num)
    |> Enum.each(fn n ->
        true = :ets.update_element(ets, n, {2, false})
      end)
  end


  defp get_primes(ets) do
    primes = :ets.foldr(fn({num, is_prime}, acc) -> if is_prime, do: [num | acc], else: acc end, [], ets)

    [2 | primes]
  end
end
