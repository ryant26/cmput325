% Question 1:
xreverse([], []).

xreverse([H|T], Y) :- 
	xreverse(T, Reverse),
	append(Reverse, [H], Y).

% Question 2:
xunique([], Lu).

xunique([H|T], Lu) :-
	xunique(T, Accum),
	notMember(H, Accum),
	append(Accum, [H], Lu).


 

notMember(E, []).

notMember(E, [H|T]) :-
	E \= H,
	notMember(E, T).

