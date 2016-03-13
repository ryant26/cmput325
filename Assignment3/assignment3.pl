:- module(assignment3, [xreverse/2, xunique/2, xunion/3, removeLast/3, xsubset/2, 
	clique/1, allConnected/1, allCliques/2, cliqueOfLength/2, cliqueGreaterThan/2, difference/3,
	notSubset/3, maxClique/2]).

:- use_module(graphs).

%Question 1:
xreverse([H|T], Y) :-
	accumRev([H|T], [], Y).

accumRev([], [H|T], [H|T]).

accumRev([H1|T1], Accum, Y) :-
	accumRev(T1, [H1|Accum], Y).

% Question 2:
xunique([], []).

xunique([H1|L1], [H2|L2]) :-
	H1 = H2,
	delete(L1, H1, Lp),
	xunique(Lp, L2).

% Question 3:
xunion(L1, L2, L3) :-
	append(L1, L2, L4),
	xunique(L4, L3).

% Question 4:
removeLast([X], [], X).

removeLast([H1|T1], [H1|T2], L) :-
	removeLast(T1, L2, L),
	T2 = L2.

% Question 5.1:
allConnected([_]).
allConnected([A,B|T]) :-
	connected(A,B),
	allConnected([A|T]),
	allConnected([B|T]).

connected(A,B) :- edge(A,B).
connected(A,B) :- edge(B,A).

clique(L) :- findall(X,node(X),Nodes),
             xsubset(L,Nodes), allConnected(L).

xsubset([], _).
xsubset([X|Xs], Set) :-
  append(_, [X|Set1], Set),
  xsubset(Xs, Set1).

% Question 5.2:
 maxClique(X, Cliques) :-
 	findall(H, cliqueOfLength(X, H), LengthCliques),
 	findall(H, cliqueGreaterThan(X, H), GreaterCliques),
 	notSubset(GreaterCliques, LengthCliques, Cliques).


cliqueOfLength(X,L) :-
	clique(L),
	length(L,Length),
	Length == X.

cliqueGreaterThan(X, L) :-
	clique(L),
	length(L, Length),
	Length > X.

notSubset([], L2, L2).
 
notSubset([H1|T], L2, Out) :-
	findall(X, xsubset(X, H1), Subsets),
	difference(Subsets, L2, Lp),
	notSubset(T, Lp, Out).

difference([], L2, L2).

difference([H|T], L2, L3) :-
	delete(L2, H, Lp),
	difference(T, Lp, L3).