(initget "Circulo Triangulo Rectangulo")

(initget "TUerca TOrnillo")

(getkword "Que desea dibujar TUerca TOrnillo")

(initget 1); obligado a que se ingrese un valor obligatorio
(initget 4); No permite valores negativos

(getvar "cdate")

(delay)

(entityname)
(entlast)
(entsel)


(entget (entlast)); Propiedads del ultimo objeto