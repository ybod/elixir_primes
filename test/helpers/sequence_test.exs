defmodule Primes.Helper.Sequence.Test do
  use ExUnit.Case, async: true
  doctest Primes.Helper.Sequence

  test "get_odd can return 1" do
    assert(Primes.Helper.Sequence.get_odd(1, 1) == [1])
  end

  test "get_odd cat return two odd numbers" do
    assert(Primes.Helper.Sequence.get_odd(3, 5) == [3, 5])
  end

  test "get_odd can return series of odd numbers" do
    assert(Primes.Helper.Sequence.get_odd(21, 31) == [21, 23, 25, 27, 29, 31])
  end


  test "get can return 1" do
    assert(Primes.Helper.Sequence.get(1, 1, 1) == [1])
  end

  test "get can return two elemets" do
    assert(Primes.Helper.Sequence.get(1, 2, 1) == [1, 2])
  end

  test "get can return one element with first larger that limit" do
    assert(Primes.Helper.Sequence.get(10, 5, 2) == [10])
  end

  test "get can return series of numbers" do
    assert(Primes.Helper.Sequence.get(3, 50, 6) == [3, 9, 15, 21, 27, 33, 39, 45])
  end
end
