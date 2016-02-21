(defun should-true (predicate)
    (if predicate
        T
        (and (princ "Test Failed:") nil)
    )
)

(defun should-false (predicate)
    (should-true (not predicate))
)

(defun test (single-test remaining-tests)
    (if (eval single-test)
        nil
        (print single-test)
    )
    (test-all remaining-tests)
)

(defun test-all (test-list)
    (if (null test-list)
       nil
       (test (car test-list) (cdr test-list))
    )
)


;Sample usage
(test-all '(
    (should-true
        (equal '(a 2) '(a 2))
    )
    (should-true
        (numberp 3)
    )
    (should-false
        (eq 1 1.0)
    )
    
    ;=========================== Question 1 Tests ===========================
    (should-true
      (eq T (xmember '1 '(1)))
    )
    (should-true
      (eq NIL (xmember '1 '( (1) 2 3)))
    )
    (should-true
      (eq T (xmember '(1) '((1) 2 3)))
    )
    (should-false
      (xmember nil nil)
    )
    (should-true
      (xmember nil '(nil))
    )
    (should-false
      (xmember nil '((nil)))
    )
    (should-true
      (xmember '(nil) '(1 2 3 (nil)))
    )
    (should-false
      (xmember '(nil) '(nil))
    )
    
    ;=========================== Question 2 Tests ===========================
    (should-true
      (equal '(a b c d) (flatten '(a (b c) d)))
    )
    (should-true
      (equal '(a) (flatten '((((a))))))
    )
    (should-true
      (equal '(a b c d e f) (flatten '(a (b c) (d ((e)) f))))
    )
    
    ;=========================== Question 3 Tests ===========================
    (should-true
      (equal '(a d b e c f) (mix '(a b c) '(d e f)))
    )
    (should-true
      (equal '(1 a 2 3) (mix '(1 2 3) '(a)))
    )
    (should-true
      (equal '((a) d (b c) e f g h) (mix '((a) (b c)) '(d e f g h)))
    )
    (should-true
      (equal '(1 2 3) (mix '(1 2 3) nil))
    )
    (should-true
      (equal '(1 nil 2 3) (mix '(1 2 3) '(nil)))
    )
    
    ;=========================== Question 4 Tests ===========================
    (should-true
      (equal '((1 3 5) (2 4 6)) (split '(1 2 3 4 5 6)))
    )
    (should-true
      (equal '(((a) (d e f) h) ((b c) g)) (split '((a) (b c) (d e f) g h)))
    )
    (should-true
      (equal '(nil nil) (split '()))
    )
    
    ;=========================== Question 3 & 4 Tests ===========================
    (should-true
      (equal '((a b c) (d e f)) (split (mix '(a b c) '(d e f))))
    )
    (should-true
      (equal '((1 2 3) (4 5)) (split (mix '(1 2 3) '(4 5))))
    )
    (should-true
      (equal '(a d b e c f) (let ((L '(a d b e c f))) (mix (car (split L)) (cadr (split L)))))
    )
    (should-true
      (equal nil (let ((L nil)) (mix (car (split L)) (cadr (split L)))))
    )
    
    ;=========================== Question 6 Tests ===========================
    (should-true
      (equal '(2 3) (subsetsum '(1 2 3) 5))
    )
    (should-false
      (subsetsum '(1 5 3) 2)
    )
    (should-true
      (equal '(1 16 8 4) (subsetsum '(1 16 2 8 4) 29))
    )
    (should-true
      (equal '(1 1 8) (subsetsum '(1 1 5 6 8) 10))
    )
    (should-false
       (subsetsum '(1 10 100 1000 10000) 5)
    )
))