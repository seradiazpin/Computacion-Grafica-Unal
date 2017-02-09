(defun aGrados(numberOfDegrees) 
(* pi (/ numberOfDegrees 180.0)))

(defun cords (angle h)
	(list (* (cos angle) h) (* (sin angle) h))
)

(defun rueda (C R / ang delta p2)
	(command "._circle" C R)
	(command "._circle" C (+ R 10))
	(setq ang 0.0)
	(while (< ang 360.0)
		(setq delta (cords (aGrados ang) R))
		(setq p2 (list (+ (nth 0 delta) (nth 0 C)) (+ (nth 1 delta) (nth 1 C))))
		(line )
		(command "._line" C p2 "")
		(setq ang (+ ang 10.0))
	)
)

(defun bicy ( / Rrueda1 Rrueda2 Crueda1 Crueda2 distMarco delta p2MarcoBajo p1MarcoAlto p2MarcoAlto)
 
	     (setq Rrueda1 (getreal "Radio de la rueda tracera: "))
	     (setq Rrueda2 (getreal "Radio de la rueda delantera: "))

	     (setq Crueda1 (list 0 100))
	     (setq Crueda2 (list (+ Rrueda1 Rrueda2 500.0) (+ Rrueda2 (- Rrueda1) 100)))

	     (rueda Crueda1 Rrueda1)
	     (rueda Crueda2 Rrueda2)

	     (setq distMarco (* (distance Crueda1 Crueda2) 0.5))
	     (setq delta (cords (angle Crueda1 Crueda2) distMarco))

	     (setq p2MarcoBajo (list (+ (nth 0 delta) (nth 0 Crueda1)) (+ (nth 1 delta) (nth 1 Crueda1))))
	     (setq p1MarcoAlto (list (nth 0 p2MarcoBajo) (+ 200 (* 1.5 Rrueda2))))
	     (setq p2MarcoAlto (list (- (nth 0 Crueda2) Rrueda2) (+ 200 (* 2 Rrueda2))))

	     (command "._line" Crueda1 p2MarcoBajo p2MarcoAlto p1MarcoAlto Crueda1 "")
	     (command "._line" p2MarcoAlto Crueda2 "")
	     (command "._line" p1MarcoAlto p2MarcoBajo "")
)


