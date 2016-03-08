%Question 1:
xreverse([], _).

xreverse([H|T], Y) :-
	xreverse(T, Reverse),
	append(Reverse, [H], Y).

% Question 2:
xunique([], []).

xunique([H1|L1], [H2|L2]) :-
	H1 = H2,
	delete(L1, H1, Lp),
	xunique(Lp, L2).

% Question 3:
