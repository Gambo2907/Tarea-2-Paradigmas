:-consult(sintaxis).
%TENNGO QUE HACER MAS PRUEBAS CON LA GRAMATICA
%PORQUE DA ALGUNOS ERRORES CON ALGUNAS ORACIONES
%DE ENTRADA ACEPTA "en turrialba" o 'estoy en turrialba'



%Funcion miembro
miembro(Elemento,[_|Resto]):- miembro(Elemento,Resto).
miembro(Elem,[Elem|_]).


%Para buscar el lugar en una lista de palabras
buscar_lugar(Input,Destino):- miembro(Destino,Input), lugar([Destino],[]),!.

%ESTO NO SE ESTA USANDO
obtener_lugar(L0, L) :- 
    read_line_to_string(user_input, Oracion),
    oracion(Oracion,L).



% Predicado para dividir una cadena en palabras
dividir_palabras(Cadena, Palabras) :-
    atomic_list_concat(Palabras, ' ', Cadena).

% Pruebas de interfaz
testeo :-
    write('Ingrese donde esta: '),
    read_line_to_string(user_input, Oracion),
    dividir_palabras(Oracion, ListaPalabras),
    oracion(ListaPalabras, L),%Esto comprueba que la oracion tenga la sintaxis correcta
    buscar_lugar(ListaPalabras, X),%Obtiene el lugar del texto ingresado
    format('Oracion: ~s Lugar: ~s~n', [L, X]).

   