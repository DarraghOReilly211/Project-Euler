expectedPlates(T, Result) :-
    T4 is T / 4,
    go(T4, 0, 0, T, Result).

go(I, E0, E1, T, E0) :-
    I < 0,
    !.
go(I, E0, E1, T, Result) :-
    NewI is I - 1,
    T2 is T - 2,
    NewE1 is (T + (T2 - 2 * I) * E1) / (T - round(I) - 1),
    NewE0 is (T + (T2 - 2 * I) * E0 + NewE1) / (T - round(I) - 1),
    go(NewI, NewE0, NewE1, T, Result).

main :-
    current_prolog_flag(argv, [PlateCountAtom | _]),
    atom_number(PlateCountAtom, PlateCount),
    expectedPlates(PlateCount, Result),
    format('Expected number of plates: ~2f~n', [Result]).
