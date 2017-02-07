; Punto de inicio y punto final para la linea
(setq ini 0 0)
(setq fin 1000 1000)

; centro y radio para el circulo
(setq c 0)
(setq r 500)

; Para llamar a un comando por su nombre se puede el nombre en el idioma o ._name en ingles
 
(command "._line" 10 0 1000 1000 "")
(command "._circle" c r)

; Asi se define una funcion

(defun symbol_name ( args / local_variables )
  expressions
)

; ejemplos

(defun DONE ( ) (prompt "\nbye! "))

; sin argumentos pero locales
(defun TEST ( / ANG1 ANG2)
 
	     (setq ANG1 "Monday")
	     (setq ANG2 "Tuesday")
 
	     (princ (strcat "\nANG1 has the value " ANG1))
	     (princ (strcat "\nANG2 has the value " ANG2))
	   (princ)
)

;Doblesuma

(defun +2 (VAL)
	(+ 2 VAL)
)