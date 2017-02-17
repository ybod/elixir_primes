# Primes

Straightforward implementation of [Sieve Of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) primes search algorithm in [Elixir](http://elixir-lang.org/)

Inspired by the **Exercism** task [Nth Prime in Elixir](http://exercism.io/exercises/elixir/nth-prime/readme)

## Details

`lib\sieve_of_eratosthenes_array.ex` - contains implementation of Sieve Of Eratosthenes primes search algorithm utilizing **Erlang** [array](http://erlang.org/doc/man/array.html#set-3) as a data container.

## Description

To get the list of the prime numbers up to the given Upper Limit use:
```
iex> Primes.SieveOfEratosthenes.Array.get_primes_list(10)
[2, 3, 5, 7]
```
