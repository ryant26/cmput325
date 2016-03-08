% Question 1:
xreverse([], []).

xreverse([H|T], Y) :- 
	xreverse(T, Reverse),
	append(Reverse, [H], Y).

% Question 2:
xunique([], Lu).

xunique([H|T], Lu) :-
	notMember(H, Lu),
	append(H, Lu, Lu),
	xunique(T, Lu).
 

notMember(E, []).

notMember(E, [H|T]) :-
	E \= H,
	notMember(E, T).

