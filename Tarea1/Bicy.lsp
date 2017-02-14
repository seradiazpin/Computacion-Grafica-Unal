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

; Funcion para dibujar las ruedas de las bicicleta
; C: Centro de la rueda
; R: Radio de la rueda
(defun rueda (C R / ang delta p2)
	; Se dibuja el arco interno de la rueda y arco externo que tiene 10 unidade mas de radio
	(command "._circle" C R)
	(command "._circle" C (+ R 10))

	; Mediante un siclo se dibujan las baras de la rueda cada uno con una separacion de 10º
	; Para calcular las cordenadas del segunod punto de la linea se usa cords (angulo R)

	(setq ang 0.0)
	(while (< ang 360.0)
		(setq delta (cords (aGrados ang) R))
		(setq p2 (list (+ (nth 0 delta) (nth 0 C)) (+ (nth 1 delta) (nth 1 C))))
		;(command "._layer" "_C" 250 "0" "")
		(command "._line" C p2 "")
		(setq ang (+ ang 10.0))
	)
)

; Funcion para dibujar la silla
; pini : punto en el cual se conecta a la bicicleta
(defun silla (pini / psillabajo psillaIz psillaDr)
	(setq psillabajo (list (- (nth 0 pini) 10) (+ (nth 1 pini) 50)))
	(setq psillaIz (list (- (nth 0 psillabajo) 30) (+ (nth 1 psillabajo) 20)))
	(setq psillaDr (list (+ (nth 0 psillabajo) 50) (+ (nth 1 psillabajo) 20)))
	(command "._line" pini psillabajo psillaDr psillaIz psillabajo "")
)

; Funcion para dibujar el manubrio
; pini: punto en el cual se conecta con la bicicleta
(defun manubrio (pini / parco1 parco2 parco3)
	(setq parco1 (list (+ (nth 0 pini) 50) (+ (nth 1 pini) 30)))
	(setq parco2 (list (+ (nth 0 pini) 50) (- (nth 1 pini) 30)))
	(setq parco3 (list (- (nth 0 pini) 1) (- (nth 1 pini) 30)))
	(command "._line" pini parco1 "")
	(command "._arc" parco1 parco2 parco3)
)
; Funcion para dibujar el marco de la bicicleta
; CR : centro de la rueda tracera
; p2MB : segundo punto del marco por abajo
; p2MA : segundo punto del marco por arriba
; p1MA : primer punto del marco por arriba
; CR2 : centro de la segunda rueda
(defun marco (CR p2MB P2MA P1MA CR2 / CRD p2MBD P2MAD P1MAD)

	; Variables adicionales para que el marco no sea una sola linea sino
	; con un poco de grosor
	(setq p2MBD (list (- (nth 0 p2MB) 3) (+ 5 (nth 1 p2MB))))
	(setq P2MAD (list (- (nth 0 P2MA) 8) (- (nth 1 P2MA) 5)))
	(setq P1MAD (list (+ (nth 0 P1MA) 5) (- (nth 1 P1MA) 5)))

	(command "._line" CR p2MB P2MA P1MA CR "")
	(command "._line" p2MA CR2 "")
	(command "._line" p1MA p2MB "")
	
	(command "._line" CR p2MBD P2MAD P1MAD CR "")
)

; Funcion la cual dibuja la bicicleta en su totalidad
(defun bicy ( / Rrueda1 Rrueda2 Crueda1 Crueda2 distMarco delta p2MarcoBajo p1MarcoAlto p2MarcoAlto)
		; Se piden los radios de las ruedas
	(setq Rrueda1 (getreal "Radio de la rueda tracera: "))
	(setq Rrueda2 (getreal "Radio de la rueda delantera: "))

	; Se calcula la ubicacion de las ruedas y la distancia entre ellas dependiendo de sus radios
	(setq Crueda1 (list 0 100))
	(setq Crueda2 (list 
		(+ Rrueda1 (if (= Rrueda1 Rrueda2) (* 2 Rrueda2) 200) Rrueda2) 
		(+ Rrueda2 (- Rrueda1) 100))
	)

	; Dibujamos las ruedas
	(rueda Crueda1 Rrueda1)
	(rueda Crueda2 Rrueda2)

	; Calculamos el marco mediante la distancia media entre las ruedas
	(setq distMarco (* (distance Crueda1 Crueda2) 0.5))
	(setq delta (cords (angle Crueda1 Crueda2) distMarco))

	; Calculamos los puntos del marco teniendo en cuenta el radio y la distancia anterior
	(setq p2MarcoBajo (list 
		(+ Rrueda1 (if (> Rrueda1 Rrueda2) 200 Rrueda1) (nth 0 Crueda1)) 
		(+ (nth 1 delta) (nth 1 Crueda1)))
	)
	(setq p1MarcoAlto (list (- (nth 0 p2MarcoBajo) 50) (+ 100 (* 1.5 Rrueda2))))
	(setq p2MarcoAlto (list (- (nth 0 Crueda2) Rrueda2) (+ 100 (* 2 Rrueda2))))
	;(command "._layer" "_C" "red" "0" "")
	; Dibujamos el marco
	(marco Crueda1 p2MarcoBajo p2MarcoAlto p1MarcoAlto Crueda2)

	; Dibujamos la silla
	(silla p1MarcoAlto)

	; Dibujamos el manubrio
	(manubrio p2MarcoAlto)
)		
;

