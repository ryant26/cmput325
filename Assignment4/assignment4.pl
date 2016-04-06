:- module(assignment4, [fourSquares/2, disarm/3, findElement/4, removeAll/3, sortedCheck/1]).
:- use_module(library(clpfd)).
:- use_module(library(arithmetic)).


% ======================== Question 1 ==========================
/*
*	fourSquares(Number, List)
*	True if, List contains 4 non-negative numbers whos sum is equal
*   to Number. Furthermore, the List must be sorted in ascending order.
*	
*	eg. Number = 7 -> List = [1,1,1,2]
*/
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
/*
*	disarm(ListA, ListB, Soln)
*	Each element of Soln represents one dismantlement, where a dismantlement 
*	is a list containing two elements: the first element is a list of country A's 
*	dismantlements and the second is a list of country B's dismantlements.
*
*	See Assignment specification for discussion on dismantlements
*
*	ListA - A list of country A's military divisions
*	ListB - A list of country B's military divisions
*	Soln - The solution to the disarm problem
*	
*	eg. ListA = [1,3,3,4,6,10,12], ListB = [3,4,7,9,16] -> Soln = [[[1, 3], [4]], [[3, 4], [7]], [[12], [3, 9]], [[6, 10], [16]]]
*
*
*	** Developer note: disarm checks for a trivial false case, (The sum of ListA != ListB) then delegates to optimizedDisarm
*	   for the heavy lifting **
*
*/
disarm(A,B,C) :-
	sumlist(A,X),
	sumlist(B, X),
	optimizedDisarm(A,B,C).

/*
*	optimizedDisarm(ListA, ListB, Soln)
*	A helper function for the above "disarm". This function performs the actual computation of dismantlements.
*	Arguments expected are the same as above, namely:
*	
*	ListA - A list of country A's military divisions
*	ListB - A list of country B's military divisions
*	Soln - The solution to the disarm problem
*/
optimizedDisarm([], [], []).
optimizedDisarm(A, B, [H3|R3]) :-
	findElement(A, B, L, E),
	H3 = [L, [E]],
	removeAll(L, A, Aresult),
	select(E, B, Bresult),
	disarm(Aresult, Bresult, R3), 
	sortedCheck([H3|R3]),!.

optimizedDisarm(A, B, [H3|R3]) :-
	findElement(B, A, L, E),
	H3 = [[E], L],
	removeAll(L, B, Bresult),
	select(E, A, Aresult),
	disarm(Aresult, Bresult, R3),
	sortedCheck([H3|R3]),!.

/*
*	findElement(ListA, ListB, Soln)
*	A helper function for the above "disarm". This function performs the actual computation of dismantlements.
*	Arguments expected are the same as above, namely:
*	
*	ListA - A list of country A's military divisions
*	ListB - A list of country B's military divisions
*	Soln - The solution to the disarm problem
*/
findElement(A, B, L, E):-
	msort(A, Out),
	select(X, Out, ResA),
	member(Y, ResA),
	msort(B, BOut),
	member(E, BOut),
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