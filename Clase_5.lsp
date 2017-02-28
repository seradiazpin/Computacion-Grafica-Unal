; Obtener datos de la ultima linea 
(setq line (entget(entlast)))

;-1 entity name
;8 layer
;10 , 11 puntos de la linea
; 62 Color
; 50 angulo de rotacion

; Obtener dato de la lista
(nth x dato)

; Guardar layer de las propiedades de la linea
(setq layer (nth 7 line))

; si la lista tiene punto ejemplo (8 . "0") es que solo tiene dos valores se llama parpunteado
; nth solo puede estraer el primero de este tipo
; para extraer

(car lista) ;equivalente a (nth 0 lista) o solo el primer elemento
(cdr lista) ;equivalente a (nth 1 lista) o todo menos el primero en una lista normal

; Similar a un diccionario de las listas
(assoc id lista)

; Ejemplo
(setq p1 (assoc 10 line))
(setq p1 (cdr p1))

(setq p2 (getpoint "punto"))

; Para crear lo que es similar al diccionario
(cons 10 p2)

; Para sustituir
(subst lo_nuevo lo_viejo en_donde)

(subst (cons 10 p2) (assoc 10 line) line)
(setq line1 (subst (cons 10 p2) (assoc 10 line) line))

; Modificar los datos de la entidad
(entmod line1)

; modificar color distinto del layer se agregan listas de cosas
; que : lista de lista
(append endonde que)

(append line (list (cons 62 2)))
(setq line1_mod (append line (list (cons 62 2))))




(cdate) ;año mes dia . hora minuto segundo 20170217.10290100 -> 2017/02/17.10:29:0100
(getvar 1 "CDATE")
;real a string de cdate 2:decima 6:decimales
(rtos (getvar "CDATE") 2 6)

; substring "cadena", caracter inicio , numero caracteres
(substr fecha-hora 14 2)

; String a entero
(atoi)
; parar en milisegundos NOTA REALSITIC EN LUGAR DE 2D WIREFRAME
(command "_delay" 1000)

; Modifica el bloque ADICIONAL ENTMOD 
(entupd entityname)

;Tarea reloj - no auto reloj y palos
; Hora real con los se mueven como en un reloj raeal 
; PANERL CON FECHAS