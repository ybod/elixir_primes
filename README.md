# Primes

Straightforward implementation of [Sieve Of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) primes search algorithm in [Elixir](http://elixir-lang.org/)

Inspired by the **Exercism** task [Nth Prime in Elixir](http://exercism.io/exercises/elixir/nth-prime/readme)

## Implementation Details

`lib` folder contains implementation of Sieve Of Eratosthenes primes search algorithm utilizing different data structures:

* `sieve_of_eratosthenes_array.ex`: [Erlang array](http://erlang.org/doc/man/array.html#set-3)
* `sieve_of_eratosthenes_mapset.ex`: [Elixir MapSet](https://hexdocs.pm/elixir/MapSet.html#content)

## Description

To get the list of the prime numbers up to the given Upper Limit use:
```
iex> Primes.SieveOfEratosthenes.Array.get_primes_list(10)
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
