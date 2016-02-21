(defun should-true (predicate)
    (if predicate
        T
        (and (princ "Test Failed:") nil)
    )
)

(defun should-false (predicate)
    (should-true (not predicate))
)

(defun should-equal (expr1 expr2)
  (should-true 
    (equal
      expr1
      expr2)))

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
    
    ; ================ Helper function tests ===============
    
    ; Lookup
    (should-true
        (equal (lookup 'key2 '((key val) (key2 val2))) 'val2)
    )
    (should-true
        (equal (lookup 'key '((key val) (key2 val2))) 'val)
    )
    
    ; ================ PRIMITIVE TESTS ======================
    
    ;atom return 
    (should-false
      (fl-interp nil nil))
    (should-true
      (fl-interp T nil))
    (should-true
      (equal (fl-interp 3 nil) 3))
    
    ;if
    (should-true
      (fl-interp '(if T T nil) nil))
    (should-false
      (fl-interp '(if nil T nil) nil))
    
    ; First
    (should-true
        (equal (fl-interp '(first (a b c d)) ()) 'a)
    )
    (should-false
        (equal (fl-interp '(first (a b c d)) ()) 'b)
    )
    (should-true
        (equal (fl-interp '(first ((1 2 3) b c d)) ()) '(1 2 3))
    )
    (should-true
        (equal (fl-interp '(first ((1 (2 3)) b c d)) ()) '(1 (2 3)))
    )
    
    ;cons
    (should-equal
      (fl-interp '(cons a ()) nil)
      '(a))
    (should-equal
      (fl-interp '(cons a (b)) nil)
      '(a b))
    (should-equal
      (fl-interp '(cons nil nil) nil)
      '(nil))
    
    ;null
    (should-true
      (fl-interp '(null nil) nil))
    (should-false
      (fl-interp '(null T) nil))
    (should-false
      (fl-interp '(null (9 5)) nil))
    
    ;rest
    (should-equal
      (fl-interp '(rest ()) nil)
      nil)
    (should-equal
      (fl-interp '(rest (a)) nil)
      nil)
    (should-equal
      (fl-interp '(rest (a b c)) nil)
      '(b c)
    )
    (should-equal
      (fl-interp '(rest (a (b c))) nil)
      '((b c))
    ) 
    
    ;eq
    (should-true
      (fl-interp '(eq nil nil) nil))
    (should-true
      (fl-interp '(eq 9 9) nil))
    (should-false
      (fl-interp '(eq 9 T) nil))
    (should-false
      (fl-interp '(eq nil (9 5)) nil))

    ;equal
    (should-true
      (fl-interp '(equal nil nil) nil))
    (should-true
      (fl-interp '(equal 9 9) nil))
    (should-false
      (fl-interp '(equal 9 T) nil))
    (should-false
      (fl-interp '(equal nil (9 5)) nil))
    (should-true
      (fl-interp '(equal (9 5) (9 5)) nil))
    (should-false
      (fl-interp '(equal (9 5 6) (9 5)) nil))

    
    ;number
    (should-false
      (fl-interp '(number nil) nil))
    (should-true
      (fl-interp '(number 9) nil))
    (should-false
      (fl-interp '(number (9 5)) nil))
    
    ; +
    (should-true
        (equal (fl-interp '(+ 1 2 3 4) ()) '10)
    )
    (should-true
        (equal (fl-interp '(+ 1 2 3) ()) '6)
    )
    (should-true
        (equal (fl-interp '(+ 1 (first (first ((2) 3)))) nil) '3)
    )
    
    ;and
    (should-true
      (fl-interp '(and T T) nil))
    (should-false
      (fl-interp '(and T nil) nil))
    (should-false
      (fl-interp '(and T (and T nil)) nil))
    
    ;or
    (should-true
      (fl-interp '(or nil 1) nil))
    (should-true
      (fl-interp '(or nil nil 1) nil))
    (should-true
      (fl-interp '(or nil 1 nil 1) nil))
    (should-false
      (fl-interp '(or nil nil) nil))
    
    ;not
    (should-true
      (fl-interp '(not nil) nil))
    (should-false
      (fl-interp '(not T) nil))
    (should-false
      (fl-interp '(not (not (not T))) nil))
    
    ; -
    (should-true
        (equal (fl-interp '(- 3 2) ()) '1)
    )
    (should-true
        (equal (fl-interp '(- 3 4) ()) '-1)
    )
    
    ; *
    (should-true
        (equal (fl-interp '(* 3 2) ()) '6)
    )
    (should-true
        (equal (fl-interp '(* -3 4) ()) '-12)
    )
    (should-true
        (equal (fl-interp '(* -3 0) ()) '0)
    )
    
    ;>
    (should-true
      (fl-interp '(> 1 0) nil))
    (should-false
      (fl-interp '(> -1 0) nil))

    ;<
    (should-true
      (fl-interp '(< 0 1) nil))
    (should-false
      (fl-interp '(< 0 -1) nil))

    ;=
    (should-true
      (fl-interp '(= 1 1) nil))
    (should-false
      (fl-interp '(= -1 0) nil))

    ;======================================== User Function Tests =======================
    (should-equal
      (fl-interp
        '(f (g 2) (g 1)) 
        '((g X = (+ 1 X))
          (f X Y = (+ X Y))))
      5)
    (should-equal
      (fl-interp
        '(count (1 2 3)) 
        '((count L = (if (null L)
                         0
                         (+ 1 (count (rest L)))))))
      3)
    (should-equal
      (fl-interp
        '(count (1 (2 a) nil 3)) 
        '((count L = (if (null L)
                         0
                         (+ 1 (count (rest L)))))))
      4)
    (should-equal
      (fl-interp
        '(reverse (1 2 3))
        '((reverse X =  (if (null X) 
                nil
                (append (reverse (rest X)) 
                        (cons (first X) nil))))

          (append X Y = (if (null X) 
                          Y
                          (cons (first X) (append (rest X) Y))))))
      '(3 2 1))
    (should-equal
      (fl-interp
        '(reverse ((1 a b) 2 3))
        '((reverse X = (if (null X) 
                         nil
                         (append (reverse (rest X)) 
                                 (cons (first X) nil))))

          (append X Y = (if (null X) 
                          Y
                          (cons (first X) (append (rest X) Y))))))
      '(3 2 (1 a b)))
    (should-equal
      (fl-interp
        '(fib 1)
        '((fib n = (if (< n 2)
                         n
                         (+ (fib (- n 1)) (fib (- n 2)))))))
      1)
    (should-equal
      (fl-interp
        '(fib 2)
        '((fib n = (if (< n 2)
                         n
                         (+ (fib (- n 1)) (fib (- n 2)))))))
      1)
    (should-equal
      (fl-interp
        '(fib 7)
        '((fib n = (if (< n 2)
                         n
                         (+ (fib (- n 1)) (fib (- n 2)))))))
      13)
    (should-equal
      (fl-interp
        '(fib (fib (count (1 2 3 4 5 6))))
        '((fib n = (if (< n 2)
                         n
                         (+ (fib (- n 1)) (fib (- n 2)))))
          (count L = (if (null L)
                         0
                         (+ 1 (count (rest L)))))))
      21)
))