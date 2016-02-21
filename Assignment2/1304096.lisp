; ========================================== Main Interpreter / Evaluation Functions ================================================

; Main Function
; E - Expression
; P - Program
(defun fl-interp (E P) 
  (interp E P nil)
)

; Function for interpreting user defined functions
; Based on skeleton function given in assignment
; E - Expression
; P - Program
; C - Context
(defun interp (E P C)
	(cond
  ((key_exists E C) (lookup E C)) 
 	((atom E) E)
  	(t
     	(let ( 
               (f (car E))
               (arg (cdr E)) 
               (user_function (get_function (car E) P)) )
        
        	(cond
           		; Handle all builtins
             	((eq f 'if) (xif arg P C))
              ((eq f 'first) (caar (aor_eval arg P C)))
              ((eq f 'rest) (cdar (aor_eval arg P C)))
              ((eq f 'number) (numberp (car (aor_eval arg P C)) ))
              ((eq f 'and) (xand arg P C))
           		((eq f 'or) (xor arg P C))
             	((primitive f) (apply f (aor_eval arg P C) ))
             	
            	; Handle all user functions
            	((not (null user_function)) 
                (interp (parse_body user_function) P 
                  (append (create_context (parse_Args (cdr user_function)) (aor_eval arg P C)) C)
                )
              )
             
              ; else: f is undefined
              (t E)
                
          	)
        ) 
     )
  )   
)

; Function to do Applicative order reduction
;
; E - Expression
; P - Program
; C - Context
(defun aor_eval (E P C)
  (cond
    ((null E) nil)
    (t (cons (interp (car E) P C) (aor_eval (cdr E) P C) ))  
  )  
)


; ========================================== Helper Functions ================================================


; Helper function for determining if the argument belongs
; to the list of primitives we are implementing
;
; Note:
; only some of the primitives can exist in this list since they must
; work with 'apply'
;
; F - Function
(defun primitive (f)
	(xmember f '(+ - * > < = not null atom eq cons equal))
)


; ------------------------- Dictionary / List Helpers --------------------------------

; Function for finding a value for 
; a key in a list of key value pairs (Dict)
;
; k - Key
; d - Dictionary (list)
(defun lookup (k d)
	(cond
   		((null d) nil)
     	((equal k (caar d)) (cadar d))
      (t (lookup k (cdr d)))
    )
)

; Function for finding if a key exists in the dict
;
; k - Key
; d - Dictionary (list)
(defun key_exists (k d)
  (cond
      ((null d) nil)
      ((equal k (caar d)) t)
      (t (lookup k (cdr d)))
    )
)

; Helper to return if an element is a member of a list
;
; e - element
; l - list
(defun xmember (e l)
	(cond
   		((null l) nil)
     	((equal e (car l)) t)
      (t (xmember e (cdr l)))
   	)  
)

; ------------------------------ Logical / Branch Operation Helpers ------------------------------------

; Helper function to perform 'if'
;
; E - Expression
; P - Program
; C - Context
(defun xif (E P C) 
	(if (interp (car E) P C) 
      (interp (cadr E) P C)  
      (interp (caddr E) P C)
  ) 
)

; Helper function to perform a short circuit 'and'
;
; E - Expression
; P - Program
; C - Context
(defun xand (E P C)
  (cond
    
    ; Passed nil - nil
    ((null E) nil)
    
    ; REvaluation of current arg is nil - nil
    ((null (interp (car E) P C)) nil)
    
    ; Above are false and the rest of E is nil
    ; we must have true result
    ((null (cdr E)) t)
    
    (t (xand (cdr E) P C))   
  )
)

; Helper function to perform a short circuit 'or'
; 
; Note: Basicially opposite short circuiting strategy from 'and'
; E - Expression
; P - Program
; C - Context
(defun xor (E P C)
  (cond
      ((null E) nil)
      ((interp (car E) P C) t)
      ((null (cdr E)) nil)
      (t (xor (cdr E) P C))
  )  
)

; ------------------------- Context, Closure, User Function Helpers --------------------------------

; Function for creating contexts
;
; vars - named variables ie. x
; vals - an s expression to be mapped to a named variable
(defun create_context (vars vals)
  (cond 
    ((null vars) nil)
    (t (cons (list (car vars) (car vals)) (create_context (cdr vars) (cdr vals))))
  )
)

; Helper function for finding a function in P
;
; f - function name
; P - program
(defun get_function(f P)
  (cond
    ((null P) nil)
    ((eq (caar P) f) (car P))
    (t (get_function f (cdr P)))
  )  
)

; Helper for parsing arguments of a function
;
; f - whole function definition
(defun parse_args(f)
  (cond
    ((eq '= (car f)) nil)
    (t (cons (car f) (parse_Args (cdr f))))
  )
)

; Helper for parsing the body of a function
;
; f - whole function definition
(defun parse_body(f)
  (cond
    ((eq '= (car f)) (cadr f))
    (t (parse_body (cdr f)))
  )
)