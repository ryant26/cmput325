xreverse([], []).

xreverse([H|T], Y) :- 
	xreverse(T, Reverse),
	append(Reverse, [H], Y).