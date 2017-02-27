defmodule Primes.Helper.Sequence do
  @moduledoc """
    Helper functions for generating sequence of integers
  """

  import Integer, only: [is_odd: 1]

  @doc """
  Returns the sequence of the odd integers starting from the first element and up to the given limit. First element must be 1 or greater!

  ## Examples

     iex> Primes.Helper.Sequence.get_odd(3, 20)
     [3, 5, 7, 9, 11, 13, 15, 17, 19]
  """
  @spec get_odd(pos_integer, pos_integer) :: [pos_integer]
  def get_odd(first, limit)
    when is_odd(first) and first > 0 and limit >= first,
    do: :lists.seq(first, limit, 2)

  @doc """
  Returns the sequence of integers starting from the first element and up to the given limit with the specified increment.

  ## Examples

     iex> Primes.Helper.Sequence.get(1, 26, 3)
     [1, 4, 7, 10, 13, 16, 19, 22, 25]
  """
  @spec get(pos_integer, pos_integer, pos_integer) :: [pos_integer]
  def get(first, limit, incr) when first + incr > limit, do: [first]
  def get(first, limit, incr), do: :lists.seq(first, limit, incr)
end
