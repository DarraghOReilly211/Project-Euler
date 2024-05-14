/* The series, 1^1+2^2+3^3+⋯+10^10=10405071317
   Find the last ten digits of the series, 1^1+2^2+3^3+⋯+1000^1000 */

% Predicate to compute X^X mod 10^10
power_mod_10_10(X, Result) :-
    Result is (X^X) mod 10000000000.

% Predicate to find the last ten digits of the series up to N
last_ten_digits(N, Result) :-
    % Find all results of X^X mod 10^10 for X from 1 to N
    findall(ModResult, (between(1, N, X), power_mod_10_10(X, ModResult)), ModResults),
    sum_list(ModResults, Sum),
    Result is Sum mod 10000000000.

% Main function to calculate and print the last ten digits
main :-
    % Get the command-line arguments
    current_prolog_flag(argv, Argv),

    % Ensure there's an argument, convert it to an integer
    (   nth0(0, Argv, UserInput),
        atom_number(UserInput, Num),
        last_ten_digits(Num, Result),
        format('Last ten digits of the series: ~d~n', [Result])
    ;   format('Usage: swipl -s self_powers.pl -- <number>~n')
    ).

:- initialization(main, main).
