:- use_module(library(clpfd)).

% Sieve of Eratosthenes for generating primes
sieve(Max, Primes) :-
    numlist(2, Max, NumList),
    sieve(NumList, [], RevPrimes),
    reverse(RevPrimes, Primes).

sieve([], Primes, Primes).
sieve([P|Rs], Acc, Primes) :-
    exclude(divisible_by(P), Rs, Filtered),
    sieve(Filtered, [P|Acc], Primes).

divisible_by(P, N) :-
    N mod P #= 0.

% Prime factorization
prime_factors(N, Factors) :-
    Max is floor(sqrt(N)),
    sieve(Max, Primes),
    factorize(N, Primes, Factors).

factorize(1, _, []).
factorize(N, [P|Ps], Factors) :-
    (   N mod P #= 0
    ->  N1 #= N // P,
        factorize(N1, [P|Ps], F),
        Factors = [P|F]
    ;   factorize(N, Ps, Factors)
    ).

% Count divisors from prime factors
count_divisors(Factors, Count) :-
    run_length_encode(Factors, Encoded),
    findall(C, (
        member(_-M, Encoded),
        C #= M + 1
    ), Counts),
    foldl(mult, Counts, 1, Count).

mult(A, B, Result) :-
    Result #= A * B.

% Run-length encoding for factors
run_length_encode(List, Encoded) :-
    pack(List, Packed),
    maplist(length, Packed, Lengths),
    pairs_keys_values(Encoded, Packed, Lengths).

pack([], []).
pack([X|Xs], [[X|Ys]|Zs]) :-
    span(X, Xs, Ys, Ws),
    pack(Ws, Zs).

span(X, [X|Xs], [X|Ys], Zs) :-
    !, span(X, Xs, Ys, Zs).
span(_, Xs, [], Xs).

% Pre-calculate divisors for numbers up to MaxValue
precalculate_divisors(MaxValue, Divisors) :-
    findall(DivCount, (between(1, MaxValue, Num), d(Num, DivCount)), Divisors).

% d function (number of divisors)
d(N, DivisorCount) :-
    prime_factors(N, Factors),
    count_divisors(Factors, DivisorCount).

% M function optimized with precalculated divisors
m(N, K, MaxDivisor, Precalculated) :-
    Upper is N + K - 1,
    findall(DivCount, (between(N, Upper, Num), nth1(Num, Precalculated, DivCount)), DivCounts),
    max_list(DivCounts, MaxDivisor).

% S function optimized with precalculated divisors
s(U, K, Sum, Precalculated) :-
    Upper is U - K + 1,
    findall(MaxD, (between(1, Upper, N), m(N, K, MaxD, Precalculated)), MaxDs),
    sum_list(MaxDs, Sum).

% Main entry point
main :-
    precalculate_divisors(1000, PrecalculatedDivisors),
    s(1000, 10, Result, PrecalculatedDivisors),
    format("S(1000, 10) = ~w~n", [Result]).

:- initialization(main).
