; ========================== Some studying ================================
(
	defun cubesum(x)
	(
		cond
		((null x) 0)
		(T (+ (expt (car x) 3) (cubesum (cdr x)) ))
	)
)

(
	defun iscube(x)
	(
		iscubeHelper x 0
	)
)

(
	defun iscubeHelper(x y)
	(
		let ((cubed (* y y y))) (
			cond
			((equal cubed x) T)
			((< x 0) 
				(
					cond
					((< cubed x) nil)
					(T (iscubeHelper x (- y 1)))
				)
			)
			((> x 0)
				(
					cond
					((> cubed x) nil)
					(T (iscubeHelper x (+ y 1)))
				)
			)
		)
	)
)

; ========================== Higher Order Functions ================================
(
	defun plusOne(x) 
	(
		+ x 1
	)

)

(
	defun addOneList(x)
	(
		mapcar 'plusOne x
	)
)

(
	defun addOneLambda(x)
	(
		mapcar #'(lambda (y) (+ 1 y)) x
	)
)