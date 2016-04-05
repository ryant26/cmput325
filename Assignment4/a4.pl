% Question 2
% ==========
disarm([], [], []).
disarm(A, B, [H3|R3]) :-
	findElement(A, B, L, E),
	H3 = [E, L],
	removeAll(L, A, Aresult),
	select(E, B, Bresult),
	disarm(Aresult, Bresult, R3).

disarm(A, B, [H3|R3]) :-
	findElement(B, A, L, E),
	H3 = [E, L],
	removeAll(L, B, Bresult),
	select(E, A, Aresult),
	disarm(Aresult, Bresult, R3).


findElement(A, B, L, E):-
	member(X, A),
	member(Y, A),
	X \== Y,
	member(E, B),
	E is X + Y,
	L = [X, Y].

removeAll([], R, R). 
removeAll([H|R], List, Result) :-
	select(H, List, Res),
	removeAll(R, Res, Result).
