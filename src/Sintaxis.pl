%Lugar
%lugar(Lugar, Oración)
lugar([sanjose|S],S).
lugar([corralillo|S],S).
lugar([musgoverde|S],S).
lugar([cartago|S],S).
lugar([tresrios|S],S).
lugar([pacayas|S],S).
lugar([cervantes|S],S).
lugar([paraiso|S],S).
lugar([juanvinas|S],S).
lugar([turrialba|S],S).
lugar([cachi|S],S).
lugar([orosi|S],S).

%establecimiento
%establecimiento(Establecimiento, Oración)
establecimiento([supermercado|S],S).
establecimiento([farmacia|S],S).
establecimiento([restaurante|S],S).

%Pronombre
%pronombre(Pronombre, Oración)
pronombre([yo|S],S).
pronombre([nosotros|S],S).
pronombre([nosotras|S],S).
pronombre([mi|S],S).
pronombre([el|S],S).
pronombre([ella|S],S).
pronombre([se|S],S).
pronombre_reflexivo([me|S],S).
pronombre_reflexivo([nos|S],S).
sustantivo([destino|S],S).
sustantivo([origen|S],S).
sustantivo([salida|S],S).
sustantivo([inicio|S],S).

%Verbo
%verbo(Verbo, Oración)
verbo([dirijo|S],S).
verbo([dirijimos|S],S).
verbo([vamos|S],S).
verbo([voy|S],S).
verbo([ir|S],S).
verbo([ire|S],S).
verbo([iremos|S],S).
verbo([viajo|S],S).
verbo([viajamos|S],S).
verbo([estoy|S],S).
verbo([estamos|S],S).
verbo([pasar|S],S).
verbo([pasaremos|S],S).
verbo([pasamos|S],S).
verbo([ubico|S],S).
verbo([ubicamos|S],S).
verbo([encuentra|S],S).
verbo([encontrar|S],S).
verbo([llegar|S],S).
verbo([gustaria|S],S).
verbo([quiero|S],S).
verbo([queremos|S],S).
verbo([necesito|S],S).
verbo([necesitamos|S],S).
verbo([ubica|S],S).
verbo([es|S],S).
verbo([tengo|S],S).
verbo([tenemos|S],S).
verbo([tienen|S],S).

%Artículo
%articulo(Artículo, Oración)
articulo([un|S],S).
articulo([una|S],S).
articulo([unos|S],S).
articulo([unas|S],S).
articulo([el|S],S).
articulo([los|S],S).
articulo([la|S],S).
articulo([las|S],S).
articulo([al|S],S).

%Saludo
%saludo(Saludo, Oración)
saludo([hola|S],S).
saludo([hey|S],S).

%Conjucion
%conjucion(Conjucion, Oración)
conjucion([que|S],S).

%Nombre
%nombre(nombre, Oración)
nombre([wazelog|S],S).

%nombre_establecimiento
%nombre_establecimiento(nombre_establecimiento, Oración)
nombre_establecimiento([automercado|S],S).
nombre_establecimiento([pali|S],S).
nombre_establecimiento([fischel|S],S).
nombre_establecimiento([candelaria|S],S).
nombre_establecimiento([labomba|S],S).
nombre_establecimiento([ampm|S],S).
nombre_establecimiento([maxipali|S],S).
nombre_establecimiento([tenedorargentino|S],S).
nombre_establecimiento([pizzahut|S],S).
nombre_establecimiento([mcdonalds|S],S).

%preposicion
%preposicion(preposicion, Oración)
preposicion([a|S],S).
preposicion([ante|S],S).
preposicion([bajo|S],S).
preposicion([de|S],S).
preposicion([desde|S],S).
preposicion([en|S],S).
preposicion([entre|S],S).
preposicion([hacia|S],S).
preposicion([hasta|S],S).
preposicion([para|S],S).
preposicion([por|S],S).

%negacion
%negacion(negacion, Oración)
negacion([no|S],S).
negacion([negativo|S],S).
negacion([ninguno|S],S).



%Sintagmas-------------------------------------------------------------------------------
%Ej: pizzahut, fischel, pali

sintagma_nominal(L,S):-
    nombre_establecimiento(L,S).
%Ej: no, negativo
sintagma_nominal(L,S):-
    negacion(L,S).


sintagma_nominal(L,S):-
    pronombre_reflexivo(L,S1),
    verbo(S1,S).
%Wazelog
sintagma_nominal(L,S):-
    nombre(L,S).
%Farmacia
sintagma_nominal(L,S):-
    establecimiento(L,S).
%Yo
sintagma_nominal(L, S):-
    pronombre(L,S).

%Ej: yo me, el me,nosotros nos
sintagma_nominal(L, S):-
    pronombre(L,S1),
    pronombre_reflexivo(S1,S).

%Ej: mi origen, mi inicio, mi final
sintagma_nominal(L, S):-
    pronombre(L,S1),
    sustantivo(S1,S).

%Ej:cartago
sintagma_nominal(L, S):-
    lugar(L,S).
%Ej:el orosi
sintagma_nominal(L, S):-
    articulo(L,S1),
    lugar(S1,S).
%la farmacia
sintagma_nominal(L, S):-
    articulo(L,S1),
    establecimiento(S1,S).
%Ej hola wazelog
sintagma_nominal(L,S):-
    saludo(L,S1),
    nombre(S1,S).
%Ej:hacia cartago, para cartago, para el orosi
sintagma_nominal(L, S):-
    preposicion(L,S1),
    sintagma_nominal(S1,S).

sintagma_nominal(L, S):-
    preposicion(L,S1),
    preposicion(S1,S2),
    sintagma_nominal(S2,S).
%Ej: La farmacia
sintagma_nominal(L, S):-
    articulo(L,S1),
    nombre_establecimiento(S1,S).
%Ej: Para el restaurante
sintagma_nominal(L, S):-
    preposicion(L,S1),
    articulo(S1,S2),
    establecimiento(S2,S).


%Sintagma Verbal ---------------------------------------------------------------------------

%Ej:viajar hacia cartago, estoy en cartago
sintagma_verbal(L,S):-
    verbo(L, S1),
    sintagma_nominal(S1,S).

% Ej:quiero ir a orosi
sintagma_verbal(L,S):-
    verbo(L, S1),
    verbo(S1, S2),
    sintagma_nominal(S2,S).

%Ej:vamos a ir a cartago
sintagma_verbal(L,S):-
    verbo(L, S1),
    preposicion(S1, S2),
    verbo(S2, S3),
    sintagma_nominal(S3,S).
%Ej: vamos a cartago
sintagma_verbal(L,S):-
    verbo(L,S1),
    preposicion(S1,S2),
    sintagma_nominal(S2,S).
%Ej: vamos
sintagma_verbal(L,S):-
    verbo(L, S1),
    conjucion(S1,S).

%Oraciones ----------------------------------------------------------------------------------------------

%Ej:cartago, a cartago
oracion(L,S):-
    sintagma_nominal(L,S).

%Ej:a el orosi
oracion(L,S):-
    sintagma_nominal(L,S1),
    sintagma_nominal(S1,S).

%Ej:ire a cartago
oracion(L,S):-
    sintagma_verbal(L,S).

%Ej:nuestro destino es llegar a cartago
oracion(L,S):-
    sintagma_nominal(L,S1),
    sintagma_verbal(S1,S).

%Ej:nos vamos a cartago.
oracion(L,S):-
    pronombre_reflexivo(L,S1),
    verbo(S1,S2),
    sintagma_nominal(S2,S).






