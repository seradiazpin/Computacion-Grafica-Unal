
; Sergio Alejandro Diaz Pinilla - 1032458183
; ------- Tarea 2 - Reloj --------------


; funcion para pasar de grados a radianes
; grado: grado a comvertir
(defun aGrados(grado) 
	(* pi (/ grado 180.0))
)

; funcion para calcular las componentes de una linea mediante su angulo y tamaño
; angle : angulo de la linea
; h : tamaño de la linea
(defun cords (angle h)
	(list (* (cos angle) h) (* (sin angle) h))
)

; funcion para calcular el modulo entre dos numeros
; a : primer valor
; b : segundo valor
(defun mod(a b) (fix (rem a b)))



; funcion para dibujar las barras del reloj, solo se uso una vez
; C : Centro reloj
; R : Radio Reloj
(defun angReloj(C R)
	(setq ang 0.0)
	(while (< ang 360.0)
		(setq delta (cords (aGrados ang) R))
		(setq p1 (list (+ (* 0.90 (nth 0 delta)) (nth 0 C)) (+ (* 0.90 (nth 1 delta)) (nth 1 C))))
		(setq p2 (list (+ (nth 0 delta) (nth 0 C)) (+ (nth 1 delta) (nth 1 C))))
		(if (= (mod ang 5) 0) 
			(setq p1 (list (+ (* 0.80 (nth 0 delta)) (nth 0 C)) (+ (* 0.80 (nth 1 delta)) (nth 1 C))))
		)
		(command "._line" p1 p2 "")
		(setq ang (+ ang 6.0))
	)
)

; funcion para animar al reloj CUIDADO LOOP INFINITO
(defun animate()
	; Segundero 
	(command "._insert" "segundero" "35.2035,47.1095" "" "" 0)
	(setq segundero (entget (entlast)))
	; Minutero
	(command "._insert" "minutero" "35.2035,47.1095" "" "" 0)
	(setq minutero (entget (entlast)))
	; Horas
	(command "._insert" "horas" "35.2035,47.1095" "" "" 0)
	(setq horas (entget (entlast)))


	
	; Fecha de este momento
	(setq fechahora (rtos (getvar "CDATE") 2 6))

	(setq year (substr fechahora 1 4))
	(setq mes (substr fechahora 5 2))
	(setq dia (substr fechahora 7 2))

	; Lista para identificar los meses
	(setq meses (list "Ene" "Feb" "Mar" "Abr" "Jun" "Jul" "Ago" "Sep" "Oct" "Nov" "Dic"))
	
	; Inicializar reloj
	(setq hor (atoi (substr fechahora 10 2)))
	(setq minu (atoi (substr fechahora 12 2)))
	(setq seg (atoi (substr fechahora 14 2)))
	
	;Texto  del reloj dijital
	(command "._text" "17,11.8201" 4.7233 0 hor 0)
	(setq horasD (entget (entlast)))
	(command "._text" "30,11.8201" 4.7233 0 minu 0)
	(setq minD (entget (entlast)))
	(command "._text" "45,11.8201" 4.7233 0 seg 0)
	(setq segD (entget (entlast)))

	(command "._text" "17,6.6" 3.7233 0 (nth (- (atoi mes) 1) meses) 0)
	(command "._text" "28,6.6" 3.7233 0 dia 0)
	(command "._text" "34,6.6" 3.7233 0 year 0)

	(setq twopi (* 2.0 pi))

	; Deltas de tiempo
	(setq dtHor 0.00833333333)
	(setq dtMin 0.1)

	(setq angCalcSeg (* twopi (- 1.0 (/ seg 60.0))))
	(setq segundero (subst (cons 50 angCalcSeg) (assoc 50 segundero) segundero))
	(entmod segundero)
	; Minutos

	(setq angCalcMin (* twopi (- 1.0 (/ ( + minu (/ seg 60.0)) 60.0))))
	(setq minutero (subst (cons 50 angCalcMin) (assoc 50 minutero) minutero))
	(entmod minutero)
	; Hora
	(setq horaCalc (* twopi (- 1.0 (/ (+ hor (/ minu 60.0)) 12.0)))) 
	(if (> horaCalc 1)
		(setq horaCalc (- horaCalc 1))
	)
	(setq angCalcHor horaCalc)
	(setq horas (subst (cons 50 angCalcHor) (assoc 50 horas) horas))
	(entmod horas)


	(while (< seg 60)
		; Segundos

		(setq angCalcSeg (- angCalcSeg (aGrados 6)))
		(setq segundero (subst (cons 50 angCalcSeg) (assoc 50 segundero) segundero))
		(setq seg (+ 1 seg))
		(setq segD (subst (cons 1 (itoa seg)) (assoc 1 segD) segD))
		(entmod segundero)
		(entmod segD)
		; Minutos

		(setq angCalcMin (- angCalcMin (aGrados dtMin)))
		(setq minutero (subst (cons 50 angCalcMin) (assoc 50 minutero) minutero))
		(if (= seg 60) (setq minu (+ 1 minu)))
		(setq minD (subst (cons 1 (itoa minu)) (assoc 1 minD) minD))
		(entmod minutero)
		(entmod minD)
		; Hora

		(setq angCalcHor (- angCalcHor (aGrados dtHor)))
		(setq horas (subst (cons 50 angCalcHor) (assoc 50 horas) horas))

		(if (= minu 60) (setq hor (+ 1 hor)))
		(setq horasD (subst (cons 1 (itoa hor)) (assoc 1 horasD) horasD))
		(entmod horas)
		(entmod horasD)


		(command "_delay" 1000)

		; Validamos valores para las fechas
		(if (= seg 60)
			(setq seg 0)
		)
		(if (= minu 60)
			(setq minu 0)
		)
		(if (= hor 24)
			(setq hor 0)
		)
	)
)
