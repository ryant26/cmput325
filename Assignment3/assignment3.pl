:- module(assignment3, [xreverse/2, xunique/2, xunion/3, removeLast/3, xsubset/2, clique/1, allConnected/1, allCliques/2, findCliques/2]).

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
% maxClique()

allCliques(L, Out) :-
	findall(Subset, xsubset(Subset, L), Subsets),
	findCliques(Subsets, Out).

findCliques([], _).

findCliques([H1|T1], [H1|T2]) :-
	clique(H1),
	findCliques(T1, T2).

findCliques([_|T1], L) :-
	findCliques(T1, L).