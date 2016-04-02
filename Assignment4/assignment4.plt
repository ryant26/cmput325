:- use_module(assignment4).

:- begin_tests(assignment4).

% ========================= Q1: Reverse Tests ====================== 
    test(square1) :-
        square(1).

    test(square2) :-
        square(4).

    test(square3) :-
        \+ square(5).

    test(square4) :-
        \+ square(7).

    test(square5) :-
        square(9).

    test(square5) :-
        square(16).

