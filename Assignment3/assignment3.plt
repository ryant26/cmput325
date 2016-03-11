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

    % ========================= Q3: Union Tests  ====================== 
    test(union1) :-
        xunion([a,c,a,d], [b,a,c], L), 
        L == [a,c,d,b].

    test(uinion2) :-
        xunion([a,c,d], [b,a,c], [a,c,d,b]).
        
    test(uinion2, [fail]) :-
        xunion([a,c,d], [b,a,c], [a,c,d,b,a]).

    % ========================= Q4: Remove Last Tests ====================== 
    test(removeLast1, [nondet]) :-
        removeLast([a,c,a,d], L1, Last),
        L1 == [a,c,a],
        Last == d.

    test(removeLast2, [nondet]) :-
        removeLast([a,c,a,d], L1, d),
        L1 == [a,c,a].

    test(removeLast3, [fail]) :-
        removeLast([a,c,a,d], L1, [d]),
        L1 = [a,c,a].

    test(removeLast4, [nondet]) :-
        removeLast([a], L1, Last),
        L1 = [],
        Last = a.

    test(removeLast5, [nondet]) :-
        removeLast([[a,b,c]], L1, Last),
        L1 = [],
        Last = [a,b,c].

    % ========================= Q5: AllConnected Tests ====================== 
    test(allConnected1, [nondet]) :-
        allConnected([a,b,c]).

    test(allConnected2, [nondet, fail]) :-
        allConnected([a,b,c,d]).

    test(allConnected3, [nondet]) :-
        allConnected([a,d]).

    test(allConnected4, [nondet]) :-
        allConnected([d,a]).

    test(allConnected5, [nondet]) :-
        allConnected([a,e]).

    test(allConnected6, [nondet]) :-
        allConnected([e,a]).

    test(allConnected7, [nondet, fail]) :-
        allConnected([b,e]).

    test(allConnected8, [nondet, fail]) :-
        allConnected([e,b]).

    test(allConnected9, [nondet]) :-
        allConnected([b,c]).

    test(allConnected10, [nondet]) :-
        allConnected([c,b]).

    % ========================= Q5: AllConnected Tests ====================== 
    test(clique1, [nondet]) :-
        clique([a,b,c]).

    test(clique2, [nondet, fail]) :-
        clique([a,b,c,d]).

    test(clique3, [nondet]) :-
        clique([a,d]).

    test(clique5, [nondet]) :-
        clique([a,e]).

    test(clique7, [nondet, fail]) :-
        clique([b,e]).

    test(clique9, [nondet]) :-
        clique([b,c]).

:- end_tests(assignment3).