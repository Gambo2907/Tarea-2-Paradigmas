
%grafo de ejemplo con sus respectivos vecinos y su peso.

grafo([
    (   sanjose,[(corralillo,22),(cartago,20)]),
    (   corralillo,[(sanjose,22),(musgoverde,6)]),
    (   musgoverde,[(corralillo,6),(cartago,10)]),
    (   cartago, [(sanjose,20),(musgoverde,10),(tresrios,8),(paraiso,10),(pacayas,13)]),
    (   tresrios,[(sanjose,8),(pacayas,15)]),
    (   pacayas, [(tresrios,15),(cartago,13),(cervantes,8)]),
    (   cervantes,[(pacayas,8),(juanviñas,5),(cachi,7)]),
    (   turrialba,[(pacayas,18),(cachi,40)]),
    (   juanviñas,[(turrialba,4)]),
    (   paraiso,[(cervantes,4),(cachi,10),(orosi,8)]),
    (   cachi,[(paraiso,10),(orosi,12),(turrialba,40),(cervantes,7)]),
    (   orosi,[(paraiso,8),(cachi,10)])
]).


