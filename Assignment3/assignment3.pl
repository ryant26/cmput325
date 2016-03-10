:- module(assignment3, [xreverse/2, xunique/2, xunion/3]).

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