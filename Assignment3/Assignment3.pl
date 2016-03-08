%Question 1:
xreverse([], _).

xreverse([H|T], Y) :-
	xreverse(T, Reverse),
	append(Reverse, [H], Y).

% Question 2:
xunique([A], [A]).

xunique([A|L1], [A|L2]) :-
	delete(L1, A, Lp),
	xunique(Lp, L2).

xunique([H1|T1], [H2|T2]) :-
	xunique(T1, [H2|T2]).