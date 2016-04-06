%==============================================================
/*
*	Name: Ryan Thornhill
*	ID: 1304096
*	Date: April 5, 2016
*/
%==============================================================
:- use_module(library(clpfd)).

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
*	findElement(ListA, ListB, OutputList, OutputElement)
*	A helper function for the above "optimizedDisarm". This function chooses two unique
*	elements from ListA whos sum is equal to 1 element in ListB. The two unique elements from
* 	ListA are output in OutputList, the element from ListB is output in OutputElement.
*	
*	eg. ListA = [1,3], ListB = [4,5] -> OutputList = [1,3], OutputElement = 4
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

/*
*	removeAll(ToRemove, List, Result)
*	A helper function for the above "optimizedDisarm". This function removes the first occurance
*	of each element in ToRemove from List. The resulting list is output in Result.
*	
*	eg. ToRemove = [1,3], ListB = [1,3,3,5,6] -> Result = [3,5,6]
*/
removeAll([], R, R). 
removeAll([H|R], List, Result) :-
	select(H, List, Res),
	removeAll(R, Res, Result).

/*
*	sortedCheck(list)
*	returns true if list is sorted in ascending order according to the sum 
* 	of the first element in each sublist. 
*	
*	eg. list = [ [[3,1], [10,20]], [[1,1], [30,20]] ] -> false 
*				  (4)         >      (2)
*
*   eg. list = [ [[2,2], [10,20]], [[1,5], [30,20]] ] -> true
*				  (4)         <      (6)
*/
sortedCheck([]).
sortedCheck([_]).
sortedCheck([[H1, _], [H2, _]|R]) :-
	sumlist(H1, X),
	sumlist(H2, Y),
	X =< Y,
	sortedCheck(R).