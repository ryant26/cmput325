%Question 1:
xreverse([], _).

xreverse([H|T], Y) :-
	xreverse(T, Reverse),
	append(Reverse, [H], Y).

% Question 2:
xunique([A], [A]).

xunique([A|L1], [A|L2]) :-
	xunique(L1, L2).

xunique([H1|T1], [H2|T2]) :-
	member(H1, T1),
	xunique(T1, [H2|T2]).