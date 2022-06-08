# TP Assemby
Trabajo Practico de la materia Organizacion del Computador de la Facultad de Ingenieria de la Universidad de Buenos Aires 


## Consigna

### Manejo de Conjuntos (II)
Desarrollar un programa en assembler Intel 80x86 que permita definir n conjuntos (con n <= 6) cuyos
elementos tienen una longitud de 1 a 2 caracteres alfanuméricos (A..Z , 0..9).
<br><br>

El programa deberá responder las siguientes consultas:
* Pertenencia de un elemento a un conjunto.
* Igualdad de dos conjuntos.
* Inclusión de un conjunto en otro
* Unión entre conjuntos.
<br><br>

Por ejemplo:
* Ca = {0, 1, 3, B, F}
* Cb = {0, F}
<br><br>Cb está incluido en Ca

<br>

*Nota: El tamaño máximo de cada conjunto será de 20 elementos. Tener en cuenta que el orden de los caracteres en un elemento lo diferencia de otro conformado por los mismos  aracteres, siendo así que el elemento AZ es distinto que el elemento ZA y que la unión de dos conjuntos puede resultar en un conjunto con más de 20 elementos o en un conjunto vacío.*