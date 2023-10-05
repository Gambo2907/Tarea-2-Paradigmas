:-consult(sintaxis).
:-consult(grafo).
%TENNGO QUE HACER MAS PRUEBAS CON LA GRAMATICA
%PORQUE DA ALGUNOS ERRORES CON ALGUNAS ORACIONES
%DE ENTRADA ACEPTA "en turrialba" o 'estoy en turrialba'
%voy para "destino"


%Funcion miembro
miembro(Elemento,[_|Resto]):- miembro(Elemento,Resto).
miembro(Elem,[Elem|_]).



%Para buscar el lugar en una lista de palabras
buscar_lugar(Input,Destino):- miembro(Destino,Input), lugar([Destino],[]),!.
buscar_establecimiento(Input,Establecimiento):- miembro(Establecimiento,Input), establecimiento([Establecimiento],[]),!.

%ESTO NO SE ESTA USANDO
obtener_lugar(L0, L) :-
    read_line_to_string(user_input, Oracion),
    oracion(Oracion,L).



% Predicado para dividir una cadena en palabras
dividir_palabras(Cadena, Palabras) :-
    atomic_list_concat(Palabras, ' ', Cadena).

suma(X, Y, Z) :- Z is X + Y.


quitar_primero([_|Resto], Resto).

unir(Lista1, Lista2, Resultado) :-
    append(Lista1, Lista2, Resultado).

buscar(X,Y,'no',KM,P,KM2, P2,KM3,P3,P4) :-
    findminpath(X,Y,Km,P),
    format('La ruta más corta es la siguiente. KM: ~w Ruta mas corta: ~w~n', [Km,P]).


buscar(X,Y,'supermercado',KM,P,KM2, P2,KM3,P3,P4) :-
    write('¿Cuál supermercado?; '),
    read_line_to_string(user_input, Oracion3),
    dividir_palabras(Oracion3, ListaPalabras3),
    oracion(ListaPalabras3, L3),%Esto comprueba que la oracion tenga la sintaxis correcta
    buscar_lugar(ListaPalabras3, A),%Obtiene el lugar del texto ingresado
    format('¿Donde queda ~w?: ', [A]),
    read_line_to_string(user_input, Oracion4),
    dividir_palabras(Oracion4, ListaPalabras4),
    oracion(ListaPalabras4, L4),%Esto comprueba que la oracion tenga la sintaxis correcta
    buscar_lugar(ListaPalabras4, B),%Obtiene el lugar del texto ingresado
    format('Oracion: ~w Lugar: ~w~n', [L4, B]),
    findminpath(X,B,Km,P),
    findminpath(B,Y,Km2,P2),
    suma(Km,Km2,Km3),
    quitar_primero(P2,P4),
    unir(P,P4,P3),
    format('La ruta más corta es la siguiente. KM: ~w Ruta mas corta: ~w~n', [Km3,P3]).




buscar(X,Y,Z,KM,P,KM2, P2,KM3,P3,P4) :-
    findminpath(X,Z,Km,P),
    findminpath(Z,Y,Km2,P2),
    suma(Km,Km2,Km3),
    quitar_primero(P2,P4),
    unir(P,P4,P3),
    format('La ruta más corta es la siguiente. KM: ~w Ruta mas corta: ~w~n', [Km3,P3]).






% Pruebas de interfaz
testeo :-
    write('Bienvenido a Wazelog la mejor lógica para llegar a su destino'),
    nl,
    write('Ingrese donde esta: '),
    %hola wazelog estoy en ...
    read_line_to_string(user_input, Oracion),
    dividir_palabras(Oracion, ListaPalabras),
    oracion(ListaPalabras, L),%Esto comprueba que la oracion tenga la sintaxis correcta
    buscar_lugar(ListaPalabras, X),%Obtiene el lugar del texto ingresado
    format('Oracion: ~w Lugar: ~w~n', [ListaPalabras, X]),
    write('Muy bien, ¿cual es su destino?: '),
    read_line_to_string(user_input,Oracion2),
    dividir_palabras(Oracion2, ListaPalabras2),
    oracion(ListaPalabras2, L2),
    buscar_lugar(ListaPalabras2, Y),
<<<<<<< HEAD
    nl,
    write('Perfecto, ¿tiene algun destino intermedio?: '),
    read_line_to_string(user_input,Oracion3),
    dividir_palabras(Oracion3, ListaPalabras3),
    oracion(ListaPalabras3, L3),
    buscar_establecimiento(ListaPalabras3, Z),
    format('Oracion: ~w Establecimiento: ~w~n', [ListaPalabras3, Z]),
    nl,
    findminpath(X,Y,Km,P),
    format('La ruta más corta es la siguiente. ~w km.  Ruta mas corta: ~w~n', [Km, P]),
    nl,
    format('Gracias por utilizar Wazelog').
=======
    write('Excelente, ¿Tiene algún destino intermedio?: '),
    %hola wazelog estoy en ...
    read_line_to_string(user_input, Oracion3),
    dividir_palabras(Oracion3, ListaPalabras3),
    oracion(ListaPalabras3, L3),%Esto comprueba que la oracion tenga la sintaxis correcta
    buscar_lugar(ListaPalabras3, Z),%Obtiene el lugar del texto ingresado
    format('Oracion: ~w Lugar: ~w~n', [L3, Z]),
    buscar(X,Y,Z,KM,P,KM2, P2,KMT, P3,P4).
>>>>>>> 0d1c3eb82f007e1f316e58feb729b20ca9d88b79



