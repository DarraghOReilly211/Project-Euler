% Check if a number is a valid 123-number
is_123_number(1).
is_123_number(2).
is_123_number(3).
is_123_number(N) :-
    N > 3,
    number_chars(N, Digits),
    all_members(Digits, ['1', '2', '3']),
    findall(X, (member(D, Digits), number_chars(X, [D])), Counts),
    all_123_numbers(Counts).

% Check if all elements in the list are 123-numbers
all_123_numbers([]).
all_123_numbers([H|T]) :-
    is_123_number(H),
    all_123_numbers(T).

% Helper predicate to check if all elements of the first list are members of the second list
all_members([], _).
all_members([H|T], List) :-
    member(H, List),
    all_members(T, List).

% Find the N-th 123-number
find_123_number(N, Number) :-
    UpperLimit is 1000,  % Arbitrary upper limit for brute force approach
    numlist(1, UpperLimit, Range),
    include(is_123_number, Range, Seq),
    nth1(N, Seq, Number).

% Modulo operation
modulo(Number, ModuloResult) :-
    ModuloBase = 123123123,
    ModuloResult is Number mod ModuloBase.

% Main entry point
% Main entry point
main :-
    current_prolog_flag(argv, Arguments),
    (   Arguments = [Arg],
        atom_number(Arg, N) ->
        write('Finding the '), write(N), write('th 123-number...'), nl,
        (   find_123_number(N, Number) ->
            write('Found number: '), write(Number), nl,
            modulo(Number, ModuloResult),
            write('Modulo result: '), write(ModuloResult), nl
        ;   write('Error: Unable to find the 123-number.'), nl
        )
    ;   write('Error: Invalid command line arguments. Please provide a single numeric argument.'), nl
    ).


% Direct the interpreter to execute the main predicate upon startup.
:- initialization(main).
