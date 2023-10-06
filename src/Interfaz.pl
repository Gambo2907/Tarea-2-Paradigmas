:-consult(sintaxis).
:-consult(grafo).



%Funcion miembro
miembro(Elemento,[_|Resto]):- miembro(Elemento,Resto).
miembro(Elem,[Elem|_]).



%Busca el lugar en una lista de palabras
buscar_lugar(Input,Destino):- miembro(Destino,Input), lugar([Destino],[]),!.

%Busca el establecimiento en una lista de palabras
buscar_establecimiento(Input,Establecimiento):- miembro(Establecimiento,Input), establecimiento([Establecimiento],[]),!.

%Busca el nombre del establecimiento en una lista de palabras
buscar_nombre_establecimiento(Input,NombreEstablecimiento):-miembro(NombreEstablecimiento,Input),nombre_establecimiento([NombreEstablecimiento],[]),!.

%Busca si la palabra es negacion
buscar_negacion(Input,Negacion):-miembro(Negacion,Input),negacion([Negacion],[]),!.

%Mensaje de error
mensaje_error:- write("No te he entendido o el lugar que ingreso no existe").

% Predicado para dividir una cadena en palabras
dividir_palabras(Cadena, Palabras) :-
    atomic_list_concat(Palabras, ' ', Cadena).

%Predicado de suma
suma(X, Y, Z) :- Z is X + Y.

%Predicado que quita el primer elemento de una lista
quitar_primero([_|Resto], Resto).

%Predicado que une listas
unir(Lista1, Lista2, Resultado) :-
    append(Lista1, Lista2, Resultado).

% Predicado que busca la ruta mas corta, en este se busca sin un lugar
% intermedio
buscar(X,Y,0,KM,P,KM2, P2,KM3,P3,P4) :-
    findminpath(X,Y,Km,P),
    format('La ruta más corta es la siguiente.'),nl,
    format('Ruta mas corta: ~w~n ~w km', [P,Km]),nl.

% El o logico del predicado buscar, en este caso busca la ruta mas corta
% con un lugar intermedio
buscar(X,Y,Z,KM,P,KM2, P2,KM3,P3,P4) :-
    findminpath(X,Z,Km,P),
    findminpath(Z,Y,Km2,P2),
    suma(Km,Km2,Km3),
    quitar_primero(P2,P4),
    unir(P,P4,P3),
    format('La ruta más corta es la siguiente.'),nl,
    format('Ruta mas corta: ~w~n ~w km', [P3,Km3]),nl.

% Predicado que consulta al usuario el lugar de inicio para encontrar la
% ruta mas corta
consultar_inicio(Inicio):-

    write("Wazelog: Por favor indique donde se encuentra"), nl,
    read_line_to_string(user_input, Oracion),
    dividir_palabras(Oracion, ListaPalabras),
    oracion(ListaPalabras, _),
    buscar_lugar(ListaPalabras, Inicio), !.

consultar_inicio(Inicio):- mensaje_error, nl, consultar_inicio(Inicio). %Si el usuario escribe algo incorrecto tira mensaje de error

% Predicado que consulta al usuario el lugar de destino para encontrar
% la ruta mas corta
consultar_destino(Destino):-
    write("Wazelog: ¿Cual es su destino?: "), nl,
    read_line_to_string(user_input,Oracion2),
    dividir_palabras(Oracion2, ListaPalabras2),
    oracion(ListaPalabras2, L2),
    buscar_lugar(ListaPalabras2, Destino),!.

consultar_destino(Destino):- mensaje_error, nl, consultar_destino(Destino). %Si el usuario escribe algo incorrecto tira mensaje de error

% Predicado que consulta al usuario todo sobre la ruta intermedia para
% encontrar la ruta mas corta
busqueda_intermedio_positiva(Inicio,Destino,Oracion,Z,Int):-
    write("Wazelog: ¿Cual "), write(Z),write("?: "),nl, %pregunta al usuario sobre el nombre del establecimiento que quiere visitar
    read_line_to_string(user_input,Oracion4), %obtiene la respuesta del usuario y la convierte en string
    dividir_palabras(Oracion4, ListaPalabras4), %divide las palabras
    oracion(ListaPalabras4, L4), % obtiene la oracion dividida
    buscar_nombre_establecimiento(ListaPalabras4,NomEst),!, %busca el nombre del establecimiento y cuando lo encuentra hace el corte para que no busque mas
    write(" Wazelog: ¿Donde se encuentra "),write(NomEst),write("?: "),nl, %pregunta al usuario donde se encuentra el establecimiento
    read_line_to_string(user_input,Oracion5),  %obtiene la respuesta del usuario y la convierte en string
    dividir_palabras(Oracion5, ListaPalabras5), %divide las palabras
    oracion(ListaPalabras5, _),  % obtiene la oracion dividida
    buscar_lugar(ListaPalabras5, Int),!, %busca el lugar en donde esta el establecimiento y cuando lo encuentra hace el corte para que no busque mas
    buscar(Inicio,Destino,Int,_,_,_,_,_,_,_). %busca la ruta mas corta con un intermedio

busqueda_intermedio_positiva(Inicio,Destino,Oracion,Z,Int):- mensaje_error, nl, busqueda_intermedio_positiva(Inicio,Destino,Oracion,Z,Int). %Si el usuario escribe algo incorrecto tira mensaje de error


%predicado auxiliar para que busque si hay intermedio
busqueda_intermedio_aux(Inicio,Destino,Oracion,Z):-
    dividir_palabras(Oracion, ListaPalabras), %divide las palabras
    oracion(ListaPalabras, L3), % obtiene la oracion dividida
    buscar_establecimiento(ListaPalabras,Z),!, %busca el establecimiento y cuando lo encuentra hace el corte para que no busque mas
    busqueda_intermedio_positiva(Inicio,Destino,Oracion,Z,_). %llama al predicado de la busqueda positiva

%si no, la busqueda es negativa y llama a este predicado auxiliar
busqueda_intermedio_aux(Inicio,Destino,Oracion,Z):-
    dividir_palabras(Oracion, ListaPalabras),%divide las palabras
    oracion(ListaPalabras, L3),% obtiene la oracion dividida
    buscar_negacion(ListaPalabras,Z),!, %busca si hay alguna negacion y cuando lo encuentra hace el corte para que no busque mas
    buscar(Inicio,Destino,0,_,_,_,_,_,_,_). %busca la ruta mas corta sin un intermedio

%predicado que busca un intermedio para encontrar la ruta mas corta
busqueda_intermedio(Inicio,Destino,Oracion,Z):-
    write('¿Tiene algun destino intermedio?: '),nl, %pregunta al usuario si tiene un destino intermedio
    read_line_to_string(user_input,Oracion), %obtiene lo escrito por el usuario y lo convierte en string
    busqueda_intermedio_aux(Inicio,Destino,Oracion,Z). %llama al predicado auxiliar


busqueda_intermedio(Inicio,Destino,Oracion,Z):- mensaje_error, nl, busqueda_intermedio(Inicio,Destino,Oracion,Z). %Si el usuario escribe algo incorrecto tira mensaje de error

% Predicado del SE
sistemaexperto :-
    write('Bienvenido a Wazelog la mejor logica para llegar a su destino'), %saludo de inicio
    nl,
    consultar_inicio(Inicio),%PASO 1. Obtener el lugar de inicio
    write("Wazelog: ¡Muy bien!"), nl,
    consultar_destino(Destino), %PASO 2. Obtener el lugar de Destino
    busqueda_intermedio(Inicio,Destino,_,_), %PASO 3. Obtener si hay ruta intermedia o no
    format('Gracias por utilizar Wazelog'). %saludo final
