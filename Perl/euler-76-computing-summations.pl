:- use_module(library(clpfd)).

% Function to calculate the change
change(T, Result) :-
    make_cache(T, Cache),
    get_array_value(Cache, T, 99, Result).

% Create a 2D array 'Cache' to store results
make_cache(T, Cache) :-
    dim(Cache, [T+1, 100]),
    (multifor([I, J], [0, 0], [T, 99]), param(Cache, T) do
        calculate_change(I, J, Cache, T, Value),
        element([I, J], Cache, Value)
    ).

% Helper function 'calculate_change' to compute change recursively
calculate_change(_, 1, _, _, 1).
calculate_change(T, C, Cache, _, Result) :-
    C > 1,
    T #>= 0,
    T_ #= T - I * C,
    I in 0..T // C,
    C_ #= C - 1,
    get_array_value(Cache, T_, C_, SubResult),
    Result #= sum(SubResult, I),
    labeling([min], [I]).

% Retrieve command-line arguments and output the result
main :-
    % Retrieve command-line arguments
    current_prolog_flag(argv, Argv),
    (   % Check if at least one argument is provided
        Argv = [T_Argument | _] ->
        % Convert the argument to an integer
        atom_number(T_Argument, Target),
        % Compute the change for the given target
        change(Target, Result),
        % Output the result
        format('~d~n', [Result])
    ;   % If no argument is provided or an incorrect format is used
        writeln('Usage: ./computing_summations <target>')
    ).