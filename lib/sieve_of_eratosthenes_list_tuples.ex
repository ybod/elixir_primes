defmodule Primes.SieveOfEratosthenes.List.Tuples do
  @moduledoc """
  Implement Sieve of Eratosthenes algorithm for finding all prime numbers up to any given limit.
  Uses MapSet to store the list of integers for sieving.
  """

  alias Primes.Helper.Sequence

  @doc """
  Returns the list of the prime numbers up to the given limit.
  Limit must be integer larger than 1.

  ## Examples

     iex> Primes.SieveOfEratosthenes.List.Tuples.get_primes_list(10)
     [2, 3, 5, 7]

  """
  @spec get_primes_list(pos_integer) :: [pos_integer]
  def get_primes_list(limit) when limit == 2, do: [2]

  def get_primes_list(limit) when limit > 2 do
    Sequence.get_odd(3, limit)
    |> Enum.map(fn n -> {n, true} end)
    |> sieve(limit, [2])
  end

  # Sieving:
  defp sieve([{_, false}], _, primes), do: Enum.reverse(primes)
  defp sieve([{p, true}], _, primes), do: Enum.reverse([p | primes])

  # Sieving:
  defp sieve([{p, true} | t], limit, primes) do
    new_numbers =
      Sequence.get(p * p, limit, p * 2)
      |> Enum.reduce(t, fn(c, numbers) ->
          List.keyreplace(numbers, c, 0, {c, false})
        end)

    sieve(new_numbers, limit, [p | primes])
  end

  defp sieve(numbers, limit, primes), do: sieve(tl(numbers), limit, primes)
end
