:- use_module(assignment3).

:- begin_tests(assignment3).
    
    % ========================= Q1: Reverse Tests ====================== 
    test(reverse1) :-
        xreverse([7,3,4],[4,3,7]).

    test(reverse2, [fail]) :-
    	xreverse([7,3,4],[4,3,5]).

    test(reverse3) :-
    	xreverse([7,3,4], R), 
    	R == [4,3,7].

    % ========================= Q2: Unique Tests ====================== 
    test(unique1) :-
    	xunique([a,c,a,d], L), 
    	L == [a,c,d].

    test(unique2) :-
    	xunique([a,c,a,d], [a,c,d]).

	test(unique3, [fail]) :-
    	xunique([a,c,a,d], [c,a,d]).  

    test(unique3) :-
    	xunique([a,a,a,a,a,b,b,b,b,b,c,c,c,c,b,a], L),
    	L == [a,b,c]. 
    
    test(unique4) :-
    	xunique([], L),
    	L == [].  

:- end_tests(assignment3).