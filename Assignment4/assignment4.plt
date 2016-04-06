:- use_module(assignment4).

:- begin_tests(assignment4).

% ========================= Q1: fourSquares tests ====================== 
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



    % ========================= Q2: disarm tests ======================
    test(disarm1) :-
        disarm([1,3,3,4,6,10,12], [3,4,7,9,16], Sol), 
        Sol = [[[1, 3], [4]], [[3, 4], [7]], [[12], [3, 9]], [[6, 10], [16]]].

    test(disarm2, [fail]) :-
        disarm([2,2], [9], _).

    test(disarm3) :-
        disarm([1,2,3,3,8,5,5],[3,6,4,4,10],Sol),
        Sol = [[[1, 2], [3]], [[3, 3], [6]], [[8], [4, 4]], [[5, 5], [10]]].

    test(disarm4, [fail]) :-
        disarm([1,2,2,3,3,8,5],[3,2,6,4,4,10], _).

    test(disarm5, [fail]) :-
        disarm([1,2,2,3,3,8,5,5,6,7],[3,2,6,4,4,10,1,5,2],_).