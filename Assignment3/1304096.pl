% ======================== Question 1 ==============================:
/*
*	xreverse(List1, List2)
*	True if, List2 is equal to the reverse ordering of List1.
*	
*	eg. List1 = [1,2,3] -> List2 = [3,2,1]
*/
xreverse([], []).

xreverse([H|T], Y) :-
	accumRev([H|T], [], Y).

/*
*	accumRev(List1, List2, List3)
*	accumRev is the helper function for xreverse that uses an accumulator (List2).
*	accumeRev simply reverses List1 and puts the result in List3.
*	
*	accumRev([1,2,3], [], L) -> L = [3,2,1]	
*/
accumRev([], [H|T], [H|T]).

accumRev([H1|T1], Accum, Y) :-
	accumRev(T1, [H1|Accum], Y).


% ======================== Question 2 ==============================:

/*
*	xunique(List1, List2)
*	True if, List2 contains only the unique elements of List1.
*	
*	eg. xunique([1,2,1,2,3,4,5,5], L) -> L = [1,2,3,4,5]
*/
xunique([], []).

xunique([H1|L1], [H2|L2]) :-
	H1 = H2,
	delete(L1, H1, Lp),
	xunique(Lp, L2).

% ======================== Question 3 ==============================:
/*
*	xunion(List1, List2, List3)
*	True if, List3 contains the union of List1 and List2. 
*	That is, List3 contains all the unique elements of List1 and List2.
*
*	Furthermore, the ordering of elements in List3 follow the Ordering of List1 followed
* 	by List 2. 
*
*	eg. xunion([a,c,a,d], [b,a,c], L) -> L = [a,c,d,b]
*/
xunion(L1, L2, L3) :-
	append(L1, L2, L4),
	xunique(L4, L3).

% ======================== Question 4 ==============================:
/*
*	removeLast(List1, List2, Element)
*	True if, List2 contains all the elements of List1 except the last element
* 	and Element is equal to the last element if List1
*
*	List1, must be non-empty.
*
*	eg. removeLast([a,c,a,d], L1, Last)  ->  L1 = [a,c,a], Last = d. 
*/
removeLast([X], [], X).

removeLast([H1|T1], [H1|T2], L) :-
	removeLast(T1, L2, L),
	T2 = L2.	

% ======================== Question 5.1 ==============================:
/*
*	Question 5 assumes that an undirected graph is defined using:
*	
*	node(<nodename>) - which defines a node in the graph
*	edge(node1, node2) - Which defines an undirected edge from node1 to node2 
*/

/*
* 	allConnected(List1)
*	True if, all nodes in List1 can be reached from each other node in the list.
*	Where List1 is a list of nodes in an undirective graph graph. 
*
*	eg allConnected([a,b,c]) -> True
* 	if, there is a path from a to b, and a to c
*	and there is a path from b to c
*/
allConnected([_]).
allConnected([]). 	
allConnected([A,B|T]) :-
	connected(A,B),
	allConnected([A|T]),
	allConnected([B|T]).


/*
* connected(node1, node2)
* returns true if and edge exists between node1 and node2
*
* This is simply a helper function to allow a single defined edge to act 
* in a bidirectional manner
*/
connected(A,B) :- edge(A,B).
connected(A,B) :- edge(B,A).


/*
*	*This function was provided in the assignment*
*
*	clique(List)
*	return true if, each element in the list is a node in a predefined undirected 
*	graph. And there is a path from each node to each other node in the list.	
*
*
*	eg clique([a,b,c]) -> True
* 	if, there is a path from a to b, and a to c
*	and there is a path from b to c
*
*	Please note, the provided subset function does not find all permutations of the input list.
*	thus the following could happen: 
*	clique([a,b,c]) -> true.
*	clique([c,b,a]) -> false. 
*/
clique(L) :- findall(X,node(X),Nodes),
             xsubset(L,Nodes), allConnected(L).


/*
*	*This function was provided in the assignment*
*
*	xsubset(List1, List2)
*	return true if, List2 contains all subsets of List1.
*	this function does not provide every permutation of each subset. 
*
*	eg xsubset([a,b,c]m L) -> L = [[a,b,c], [a,b], [a,c], [b,c], [a], [b], [c], []]
*/
xsubset([], _).
xsubset([X|Xs], Set) :-
  append(_, [X|Set1], Set),
  xsubset(Xs, Set1).

% ======================== Question 5.2 ==============================:
/*
*	maxClique(X, Cliques)
* 	true if, Cliques contains all the maximal cliques of size X
*	that is, the number of nodes in the clique = X
*
*	A clique is maximal if it is not contained in any larger clique
*
*	in a graph with the following cliques:
*	[a,b,c],
*	[a,b],
*	[a,c],
*	[b,c],
*	[d,e]
*
*	maxclique(2,L) -> L = [[d,e]]
*	maxclique(3,L) -> L = [[a,b,c]]
*/
 maxclique(X, Cliques) :-
 	findall(H, cliqueOfLength(X, H), LengthCliques),
 	findall(H, cliqueGreaterThan(X, H), GreaterCliques),
 	subsetOfNone(GreaterCliques, LengthCliques, Cliques).

/*
*	cliqueOfLenth(X,L)
*	true if the list L contains all cliques with the number of nodes in the clique = X
*
*	This is a helper function for maxclique
*/
cliqueOfLength(X,L) :-
	clique(L),
	length(L,Length),
	Length == X.

/*
*	cliqueGreaterThan(X,L)
*	true if the list L contains all cliques with the number of nodes in the clique > X
*
*	This is a helper function for maxclique
*/
cliqueGreaterThan(X, L) :-
	clique(L),
	length(L, Length),
	Length > X.

/*
*	subsetOfNone(List1, List2, List3)
*	true if List3 contains all the elements in List2 that don't exist as
* 	a subset of ANY element in List1
*
*	eg. subsetOfNone([[a,b,c], [d,e]], [[a,b], [a,c], [c,d]], L)  ->  L = [c,d]
*
*	This is a helper function for maxclique
*/
subsetOfNone([], L2, L2).
 
subsetOfNone([H1|T], L2, Out) :-
	findall(X, xsubset(X, H1), Subsets),
	difference(Subsets, L2, Lp),
	subsetOfNone(T, Lp, Out).


/*
*	difference(List1, List2, List3)
*	true if List 3 contains all the elements in List2 that don't exist in List1
*
*	eg. difference([1,2,3,4], [1,4,5,6], L) -> L = [5,6]
*
*	This is a helper function for maxclique
*/
difference([], L2, L2).

difference([H|T], L2, L3) :-
	delete(L2, H, Lp),
	difference(T, Lp, L3).