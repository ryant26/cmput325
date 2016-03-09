:- module(assignment3, [xreverse/2, xunique/2, xunion/3]).

%Question 1:
xreverse([], _).

xreverse([H|T], Y) :-
	xreverse(T, Reverse),
	append(Reverse, [H], Y).

accumRev([], _, _).

accumRev([H1|T1], Accum, Y) :-
	accumRev(T1, [H1|Accum], Y),
	Y = Accum

% Question 2:
xunique([], []).

xunique([H1|L1], [H2|L2]) :-
	H1 = H2,
	delete(L1, H1, Lp),
	xunique(Lp, L2).

% Question 3:
