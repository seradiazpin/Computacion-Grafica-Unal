; Opciones para ventana 
(-Comando)

; En consola "opt" "val" "\n"
(command "._layer" "new" "eje" "")


;Ciclo 1
(repeat 500 (command "._circle"  "0,0" r) (setq r (+ r 1)))

;Ciclo 2
(while (< r 1000) (command "._circle"  "0,0" r) (setq r (+ r 1)))

; Condicionales
(if condicion true false)

(if condicion (prog ) (prog))

; Switch

(cond 
	(condicion)
	(condicion2)
)

; Input 
(getint)
(getreal)
; Multiple palabras
(getstring T "Mensaje")

(getpoint)
(getangle)
(getorient)
;angulos en radianes
(sin angle)

(while (< r 500) (command "._-layer" "0" "color" (rem r 255) "") (command "._circle"  "0,0" r) (setq r (+ r 1)))

;Portada
;titulo
;descripcion
;objetivos
;respaldo matematico si se tiene
;copia del programa
;Como cargar y ejecutar el programa
;Imagen de muestra
;Concluciones