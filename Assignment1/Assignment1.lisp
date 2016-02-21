; ============================================== Question 1 ==============================================

; This function takes two arguments an atom x and a list y. 
; It searches through the list y for an occurance of x.
; If found, the function returns T, otherwise nil
;
; Example Test Cases: 
; (xmember '1 '(1)) -> T
; (xmember '1 '( (1) 2 3)) -> NIL
; (xmember '(1) '((1) 2 3)) -> T
; (xmember nil '(nil)) -> T

(
	defun xmember(x y) 
		(
			cond
			((atom y) ()) 
			((equal x (car y)) (eq 1 1)) 
			((cdr y) (xmember x (cdr y)))
		)
)

; ============================================== Question 2 ==============================================

; This function takes a list x and removes all nested sublists such that the output
; is simply a list of atoms. The output list contains all atom that were present at any level
; of nesting in the input list x
; 
; Example Test Cases:
; (flatten '(a (b c) d)) -> (a b c d)
; (flatten '((((a)))))  -> (a)
; (flatten '(a (b c) (d ((e)) f))) -> (a b c d e f)
(
	defun flatten(x)
	(
			cond
			((atom x) ())
			((atom (car x)) (append (list (car x)) (flatten (cdr x))))
			(T (append (flatten (car x)) (flatten (cdr x))))
	)
)

; ============================================== Question 3 ==============================================

; This function takes 2 lists as input, x and y. It will mix the lists into a single list
; by taking elements from each list in an alternating fasion. In the case that one list is
; longer than another, the elements remaining in the longer list are appended to the end 
; of the output.
; 
; Example Test Cases:
; (mix '(a b c) '(d e f)) -> (a d b e c f)
; (mix '(1 2 3) '(a)) -> (1 a 2 3)
; (mix '((a) (b c)) '(d e f g h)) -> ((a) d (b c) e f g h)

(
	defun mix(x y)
	(
		cond
		((null x) y)
		((null y) x)
		(T (append (list (car x) (car y)) (mix (cdr x) (cdr y))))
	)
)

; ============================================== Question 4 ==============================================

; This function takes a list L as input, and outputs that splits the elements of 
; L into a list of two sublists (L1 L2), by putting elements from L into L1 and L2 alternatingly.
; 
; Example Test Cases:
; (split '(1 2 3 4 5 6)) -> ((1 3 5) (2 4 6))
; (split '((a) (b c) (d e f) g h)) -> (((a) (d e f) h) ((b c) g))
; (split '()) -> (nil nil)
(
	defun split(L)
	(
		list (skipList L) (skipList (cdr L))
	)
)

; This is a helper function that takes a list L as input and outputs a list with
; the first element and every subsequent second element of the input list.
; 
; Example Test Case:
; (skiplist '(1 2 3 4 5 6)) -> (1 3 5)
(
	defun skipList(L)
	(
		cond
		((null L) ())
		(T (cons (car L) (skipList (cddr L))) )
	)
)

; ============================================== Question 5 ==============================================

#|

5.1) 
This does not hold for:
L1 = (10)
L2 = (1 2 3 4)

(Mix L1 L2) = (10 1 2 3 4)

(Split (10 1 2 3 4)) = ((10 2 4) (1 3))


5.2)
I will prove by induction that (mix (car (split L)) (cadr (split L))) = L

Base Case: L1 = (1)

LHS:
(mix (car (split '(1))) (cadr (split '(1))))
= (mix (car ((1) ())) (cadr ((1) ()))
= (mix (1) ())
= (1)

RHS:
L = (1)

Step 2, inductive step:

assume: for all L of length <= n, (mix (car (split L)) (cadr (split L))) = L

Step 3, show true for n+1:

Case 1:
n+1 is an even number, then n was an odd number.
Let J = list length of n
Let I = list length n+1
length of (car (split J)) - length of (car (split I)) = 1
length of (cdr (split J)) - length of (cdr (split I)) = 0

thus:
length of (cdr (split J)) = length of (car (split I))

from step 2 we know the function works for lists length of (cdr (split J)). Thus the function will work when n+1 is an even number

Case 2:
n+1 is an odd number, then n was an even number.
Let J = list length of n
Let I = list length n+1
length of (car (split J)) - length of (car (split I)) = 0
length of (cdr (split J)) - length of (cdr (split I)) = -1

Thus, length of (cdr (split I)) is 1 element greater than length of (cdr (split J)). According to the definition of mix, the remaining elements of the longer list
are appended to the result. This is also a case that would have been dealt with for all odd n. So it holds that (mix (car (split L)) (cadr (split L))) = L for all
lists L
|#

; ============================================== Question 6 ==============================================

; This function takes a list L1 and a number S as input. It outputs a list that is a 
; subset of L1 who's sum is equal to S. The output list has the members in the order 
; they appeared in L1
; 
; Example Test Cases:
; (subsetsum '(1 2 3) 5) -> (2 3)
; (subsetsum '(1 16 2 8 4) '() 29) -> (1 16 8 4)
; (subsetsum '(1 5 3) '() 2) -> nil

(
	defun subsetsum(L S)
	(
		cond
		((atom L) nil)
		((null (numberp S)) nil)
		(T (findOccurances L (accumulatesubsetsum (sort (copy-list L) #'>) nil S)) )
	)
)

; This helper function takes 2 lists as input L1 L2 and a number S. It outputs a list that is a 
; subset of L1 who's sum is equal to S. It does this using the accumulator pattern of recursive functions.
; The output list has the members in the order they appeared in L1
; 
; Example Test Case:
; (accumulatesubsetsum '(1 2 3) '() 5) -> (2 3)
; (accumulatesubsetsum '(1 16 2 8 4) '() 29) -> (1 16 8 4)
; (accumulatesubsetsum '(1 5 3) '() 2) -> nil
(
	defun accumulatesubsetsum(L1 L2 S)
	(
		cond
		((null L1) (if (= S 0) L2))
		((< S 0) nil)
		((= S 0) L2)
		( (accumulatesubsetsum (cdr L1) (append L2 (list (car L1))) (- S (car L1)) )
			(accumulatesubsetsum (cdr L1) (append L2 (list (car L1))) (- S (car L1)) ) 
		)
		(T (accumulatesubsetsum (cdr L1) L2 S))
	)
)

; This function takes a lists L1 and L2 as input, it returns a list with the members
; of L2 in the order that they occur in L1.
; 
; Example Test Case:
; (findOccurances '(1 8 1 3 7 9 0) '(0 8 3)) -> (8 3 0)
(
	defun findOccurances(L1 L2)
	(
		cond
		((null L1) nil)
		((null L2) nil)
		(T (append (if (findoccurance L2 (car L1)) (list (car L1)) ) (findOccurances (cdr L1) L2)) )
	)
)

; This function takes a list L1 and an atom X and returns the atom
; if it exists as a member of L1
; 
; Example Test Case:
; (findoccurance '(1 2 3)' 2) -> 2
(
	defun findoccurance(L1 X)
	(
		cond
		((null L1) nil)
		((equal (car L1) X) X)
		(T (findoccurance (cdr L1) X))
	)
)