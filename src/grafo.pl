conexion(a,b,3).
conexion(b,c,4).
conexion(a,c,6).
conexion(c,b,4).
conexion(b,a,3).
conexion(c,a,6).

camino(Inicio,Final,Intermedio,Peso) :-
    conexion(Inicio,Intermedio,P1) , conexion(Intermedio,Final,P2), Peso is P1+P2.
