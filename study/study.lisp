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
		cond
		((equal (* y y y) x) T)
		((< x 0) 
			(
				cond
				((< (* y y y) x) nil)
				(T (iscubeHelper x (- y 1)))
			)
		)
		((> x 0)
			(
				cond
				((> (* y y y) x) nil)
				(T (iscubeHelper x (+ y 1)))
			)
		)

	)
)

; TODO:
; - Convert iscubeHelper to use let
; - do some examples with mapcar, filter and reduce