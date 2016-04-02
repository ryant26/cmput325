:- use_module(assignment4).

:- begin_tests(assignment4).

% ========================= Q1: Reverse Tests ====================== 
    test(fourSquares, [nondet]) :-
        fourSquares(1, X),
        X == [0,0,0,1].

    test(fourSquares0, [nondet]) :-
        fourSquares(0, X),
        X == [0,0,0,0].

    test(fourSquares2, [nondet]) :-
        fourSquares(2, X),
        X == [0,0,1,1].

    test(fourSquares3, [nondet]) :-
        fourSquares(3, X),
        X == [0,1,1,1].

    test(fourSquares4, [nondet]) :-
        fourSquares(4, X),
        X == [0,0,0,2].

    test(fourSquares5, [nondet]) :-
        fourSquares(5, X),
        X == [0,0,1,2].

    test(fourSquares6, [nondet]) :-
        fourSquares(6, X),
        X == [0,1,1,2].

    test(fourSquares7, [nondet]) :-
        fourSquares(7, X),
        X == [1,1,1,2].

    test(fourSquares8, [nondet]) :-
        fourSquares(8, X),
        X == [0,0,2,2].

    test(fourSquares9, [nondet]) :-
        findall(X, fourSquares(20, X), Xs),
        Xs == [[0,0,2,4],[1,1,3,3]].

    test(fourSquares10, [fail]) :-
    	fourSquares(-20,_).