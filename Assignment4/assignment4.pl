:- module(assignment4, [fourSquares/2, disarm/3, findElement/4, removeAll/3, sortedCheck/1]).
:- use_module(library(clpfd)).
:- use_module(library(arithmetic)).


% Question 1
fourSquares(N, L1) :-
	L1 = [S1,S2,S3,S4],
	L1 ins 0..N,
	(S1*S1)+(S2*S2)+(S3*S3)+(S4*S4) #= N,
	S1 #=< S2,
	S2 #=< S3,
	S3 #=< S4,
	label(L1).


% Question 2
% ==========
disarm([], [], []).
disarm(A, B, [H3|R3]) :-
	findElement(A, B, L, E),
	H3 = [L, [E]],
	removeAll(L, A, Aresult),
	select(E, B, Bresult),
	disarm(Aresult, Bresult, R3), 
	sortedCheck([H3|R3]),!.

disarm(A, B, [H3|R3]) :-
	findElement(B, A, L, E),
	H3 = [[E], L],
	removeAll(L, B, Bresult),
	select(E, A, Aresult),
	disarm(Aresult, Bresult, R3),
	sortedCheck([H3|R3]),!.


findElement(A, B, L, E):-
	select(X, A, ResA),
	member(Y, ResA),
	member(E, B),
	X =< Y,
	E is X + Y,
	L = [X, Y].

removeAll([], R, R). 
removeAll([H|R], List, Result) :-
	select(H, List, Res),
	removeAll(R, Res, Result).

sortedCheck([]).
sortedCheck([_]).
sortedCheck([[H1, _], [H2, _]|R]) :-
	sumlist(H1, X),
	sumlist(H2, Y),
	X =< Y,
	sortedCheck(R).