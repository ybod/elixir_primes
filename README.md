# Primes

Straightforward implementation of [Sieve Of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) primes search algorithm in [Elixir](http://elixir-lang.org/)

This implementation uses some common optimizations:
* it works with the sequence of **odd** integers (because the only even prime number is *2*)
* the multiples of each prime *p* generated directly by counting up from the square of the prime in increments of *2p* (for odd primes)

Inspired by the **Exercism** task [Nth Prime in Elixir](http://exercism.io/exercises/elixir/nth-prime/readme)

## Implementation Details

`lib` folder contains implementation of Sieve Of Eratosthenes primes search algorithm utilizing different data structures:

* `sieve_of_eratosthenes_array.ex` [Erlang array](http://erlang.org/doc/man/array.html)

* `sieve_of_eratosthenes_ets.ex` [Erlang ETS](http://erlang.org/doc/man/ets.html)
> This implementation inserts the sequence of odd integers into ETS as list of K/V pairs: [{3, :prime}, {5, :prime}, {7, :prime}, {9, :prime} ...]. Than odd numbers processed sequentially starting from 3, the first odd prime, and for each prime its multiples (composite numbers) removed from the ETS. On the final step we form a list of all ETS keys and return them as a list of a prime numbers.

* `sieve_of_eratosthenes_map.ex` [Elixir Map](https://hexdocs.pm/elixir/Map.html#content)
> This implementation encodes the sequence of odd integers as Map: %{3 => :prime, 5 => :prime, 7 => :prime, 9 => :prime, ...}. Than odd numbers processed sequentially starting from 3, the first odd prime, and for each prime its multiples (composite numbers) removed from the Map. On the final step we get a list of all Map keys and return them as a sorted list of a prime numbers.

* `sieve_of_eratosthenes_mapset.ex` [Elixir MapSet](https://hexdocs.pm/elixir/MapSet.html#content)

## Description

To get the list of the prime numbers up to the given Upper Limit use:
```
iex> Primes.SieveOfEratosthenes.Array.get_primes_list(10)
[2, 3, 5, 7]

iex> Primes.SieveOfEratosthenes.Map.get_primes_list(10)
[2, 3, 5, 7]

iex> Primes.SieveOfEratosthenes.MapSet.get_primes_list(10)
[2, 3, 5, 7]
```

## Algorithms comparison

You can compare different implementations of algorith by editing and executing `try_me.exs`:
```
mix run try_me.exs
```

## Testing

`test/test_data/` - contains files with lists of prime numbers from [The Prime Pages](http://primes.utm.edu/)

To run tests use standard command:
```
mix test
```

Slow tests (marked with a `@slow` tag) excluded by default. To run all test use following command:

```
mix test --include slow:true
```
