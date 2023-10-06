%nodos que pertenecen al grafo

nodo(sanjose).
nodo(corralillo).
nodo(musgoverde).
nodo(tresrios).
nodo(cartago).
nodo(pacayas).
nodo(cervantes).
nodo(paraiso).
nodo(cachi).
nodo(orosi).
nodo(turrialba).
nodo(juanvinas).

%aristas que pertenecen al grafo

arista(sanjose,corralillo,22).
arista(corralillo,sanjose,22).
arista(sanjose,cartago,20).
arista(corralillo,musgoverde,6).
arista(musgoverde,corralillo,6).
arista(musgoverde,cartago,10).
arista(cartago,sanjose,20).
arista(cartago,musgoverde,10).
arista(cartago,pacayas,13).
arista(cartago,tresrios,8).
arista(cartago,paraiso,10).
arista(tresrios,sanjose,8).
arista(tresrios,pacayas,15).
arista(pacayas,tresrios,15).
arista(pacayas,cartago,13).
arista(pacayas,cervantes,8).
arista(cervantes,pacayas,8).
arista(cervantes,juanvinas,5).
arista(cervantes,cachi,7).
arista(paraiso,cachi,10).
arista(paraiso,orosi,8).
arista(paraiso,cervantes,4).
arista(juanvinas,turrialba,4).
arista(turrialba,pacayas,18).
arista(turrialba,cachi,40).
arista(cachi,turrialba,40).
arista(cachi,cervantes,7).
arista(cachi,paraiso,10).
arista(cachi,orosi,12).
arista(orosi,paraiso,8).
arista(orosi,cachi,12).

findapath(X, Y, W, [X,Y], _) :- arista(X, Y, W). % Encuentra una ruta entre X y Y con un peso W, si hay una arista entre X y Y con peso W
findapath(X, Y, W, [X|P], V) :-                % si no encuentre una ruta entre X y Y
	\+ member(X, V),                       % es verdadero
	arista(X, Z, W1),		       % si se encuentra una ruta entre X y Z con un peso W1
	findapath(Z, Y, W2, P, [X|V]),         % y si encuentra una ruta entre Z y Y con un peso W2
	W is W1 + W2.                          % donde W es W1 + W2

:-dynamic(solution/2). %Esto declara que la relación solution/2 es dinamica, lo que significa que se pueden agregar y eliminar hechos de esta relacion en tiempo de ejecucion.

findminpath(Ini, Fin, W, P) :- % Esta regla se encarga de encontrar el camino mas corto entre los nodos Ini y Fin y devuelve el peso W y el camino P

	\+ solution(_, _), % Verifica que no haya ninguna solucion almacenada en la base de datos de soluciones

	findapath(Ini, Fin, W1, P1, []), %Llama a la regla findapath para encontrar un camino entre Ini y Fin con un peso W1 y un camino P1. La lista vacía [] se pasa como lista de nodos visitados inicial

	assertz(solution(W1, P1)), % Almacena esta solucion en la base de datos de soluciones

	!, findminpath(Ini,Fin,W,P). % Utiliza el corte para evitar la exploracion de soluciones adicionales y llama nuevamente a findminpath para verificar si hay soluciones mas cortas

findminpath(Ini, Fin, _, _) :- % Esta regla se utiliza para comparar las soluciones encontradas con las soluciones almacenadas previamente
	findapath(Ini, Fin, W1, P1, []), %Intenta encontrar un nuevo camino entre Ini y Fin con peso W1 y lo almacena en P1

	solution(W2, P2), %Obtiene una solucion previamente almacenada con peso W2 y camino P2

	W1 < W2, %Compara los pesos

	retract(solution(W2, P2)), %Retira la solucion anterior

	asserta(solution(W1, P1)), fail. %Forza el fracaso de esta regla para que Prolog busque otras soluciones

findminpath(_, _, W, P) :- solution(W,P), retract(solution(W,P)). %Esta regla se utiliza para recuperar la solución final y eliminarla de la base de datos de soluciones una vez que se ha encontrado el camino más corto



