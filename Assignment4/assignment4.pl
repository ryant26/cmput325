:- module(assignment4, [square/1, fourSquares/2]).
:- use_module(library(clpfd)).
:- use_module(library(arithmetic)).


% Question 1
fourSquares(N, L1) :-
	L1 = [S1,S2,S3,S4],
	L1 ins 0..N,
	(S1*S1)+(S2*S2)+(S3*S3)+(S4*S4) #= N,
	S1 #=< S2,
	S2 #=< S3,
	S3 #=< S4,
	label(L1).