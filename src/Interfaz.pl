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
buscar_nombre_establecimiento(Input,NombreEstablecimiento):-miembro(NombreEstablecimiento,Input),nombre_establecimiento([NombreEstablecimiento],[]),!.

buscar_negacion(Input,Negacion):-miembro(Negacion,Input),negacion([Negacion],[]),!.
%ESTO NO SE ESTA USANDO
obtener_lugar(L0, L) :-
    read_line_to_string(user_input, Oracion),
    dividir_palabras(Oracion,L2),
    oracion(Oracion,L).

mensaje_error:- write("No te he entendido o el lugar que ingreso no existe").

% Predicado para dividir una cadena en palabras
dividir_palabras(Cadena, Palabras) :-
    atomic_list_concat(Palabras, ' ', Cadena).

suma(X, Y, Z) :- Z is X + Y.


quitar_primero([_|Resto], Resto).

unir(Lista1, Lista2, Resultado) :-
    append(Lista1, Lista2, Resultado).

buscar(X,Y,0,KM,P,KM2, P2,KM3,P3,P4) :-
    findminpath(X,Y,Km,P),
    format('La ruta m�s corta es la siguiente. KM: ~w Ruta mas corta: ~w~n', [Km,P]).



buscar(X,Y,Z,KM,P,KM2, P2,KM3,P3,P4) :-
    findminpath(X,Z,Km,P),
    findminpath(Z,Y,Km2,P2),
    suma(Km,Km2,Km3),
    quitar_primero(P2,P4),
    unir(P,P4,P3),
    format('La ruta m�s corta es la siguiente. KM: ~w Ruta mas corta: ~w~n', [Km3,P3]).


consultar_inicio(Inicio):-

    write("Wazelog: Por favor indique donde se encuentra"), nl,
    read_line_to_string(user_input, Oracion),
    dividir_palabras(Oracion, ListaPalabras),
    oracion(ListaPalabras, _),
    buscar_lugar(ListaPalabras, Inicio), !.

consultar_inicio(Inicio):- mensaje_error, nl, consultar_inicio(Inicio).

consultar_destino(Destino):-
    write("Wazelog: Muy bien!"), nl,
    write("Wazelog: Cual es su destino?: "), nl,
    read_line_to_string(user_input,Oracion2),
    dividir_palabras(Oracion2, ListaPalabras2),
    oracion(ListaPalabras2, L2),
    buscar_lugar(ListaPalabras2, Destino),!.

consultar_destino(Destino):- mensaje_error, nl, consultar_destino(Destino).

busqueda_intermedio_positiva(Inicio,Destino,Oracion,Z,Int):-
    write("�Cual ...? "),nl,
    read_line_to_string(user_input,Oracion4),
    dividir_palabras(Oracion4, ListaPalabras4),
    oracion(ListaPalabras4, L4),
    buscar_nombre_establecimiento(ListaPalabras4,NomEst),
    write("�Donde se encuentra ...? "),nl,
    read_line_to_string(user_input,Oracion5),
    dividir_palabras(Oracion5, ListaPalabras5),
    oracion(ListaPalabras5, _),
    buscar_lugar(ListaPalabras5, Int),
    buscar(Inicio,Destino,Int,_,_,_,_,_,_,_).


busqueda_intermedio_negativa(Inicio,Destino,Oracion,Z):-
    dividir_palabras(Oracion, ListaPalabras3),
    oracion(ListaPalabras3, L6),
    buscar_negacion(ListaPalabras3,Z),
    buscar(Inicio,Destino,0,_,_,_,_,_,_,_),!.

busqueda_intermedio_aux(Inicio,Destino,Oracion,Z):-
    dividir_palabras(Oracion, ListaPalabras),
    oracion(ListaPalabras, L3),
    buscar_establecimiento(ListaPalabras,Z),!,
    busqueda_intermedio_positiva(Inicio,Destino,Oracion,Z,_).
busqueda_intermedio_aux(Inicio,Destino,Oracion,Z):-
    dividir_palabras(Oracion, ListaPalabras),
    oracion(ListaPalabras, L3),
    buscar_negacion(ListaPalabras,Z),!,
    busqueda_intermedio_negativa(Inicio,Destino,Oracion,Z).

busqueda_intermedio(Inicio,Destino,Oracion,Z):-
    write('�Tiene algun destino intermedio?: '),nl,
    read_line_to_string(user_input,Oracion),
    busqueda_intermedio_aux(Inicio,Destino,Oracion,Z).


busqueda_intermedio(Inicio,Destino,Oracion,Z):- mensaje_error, nl, busqueda_intermedio(Inicio,Destino,Oracion,Z).

% Pruebas de interfaz
testeo :-
    write('Bienvenido a Wazelog la mejor logica para llegar a su destino'),
    nl,
    consultar_inicio(Inicio),%PASO 1. OBTENER EL LUGAR DE INICIO/ORIGEN
    consultar_destino(Destino),
    busqueda_intermedio(Inicio,Destino,_,_),
    format('Gracias por utilizar Wazelog').
