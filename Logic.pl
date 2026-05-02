:- consult('BD.pl').

puntaje_profesion(Profesion, Evidencias, Puntaje) :-
    profesion(Profesion),
    puntaje_lista(Profesion, Evidencias, 0, Puntaje).

puntaje_lista(_, [], Puntaje, Puntaje).

puntaje_lista(Profesion, [positiva(Atributo)|Resto], Acumulado, Puntaje) :-
    puntaje_positivo(Profesion, Atributo, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

puntaje_lista(Profesion, [negativa(Atributo)|Resto], Acumulado, Puntaje) :-
    puntaje_negativo(Profesion, Atributo, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

puntaje_positivo(Profesion, Atributo, 2) :-
    afinidad(Profesion, Atributo), !.

puntaje_positivo(Profesion, Atributo, 1) :-
    fortaleza(Profesion, Atributo), !.

puntaje_positivo(_, _, 0).

puntaje_negativo(Profesion, Atributo, -3) :-
    opuesto(Atributo, Antagonia),
    antagonia(Profesion, Antagonia), !.

puntaje_negativo(Profesion, Atributo, -2) :-
    afinidad(Profesion, Atributo), !.

puntaje_negativo(_, _, 0).

recomendar(Evidencias, Profesion, Puntaje) :-
    findall(P-Prof, puntaje_profesion(Prof, Evidencias, P), Resultados),
    mejor_resultado(Resultados, Puntaje-Profesion).

mejor_resultado([Resultado], Resultado).

mejor_resultado([P1-Prof1, P2-Prof2|Resto], Mejor) :-
    P1 >= P2,
    mejor_resultado([P1-Prof1|Resto], Mejor).

mejor_resultado([P1-_, P2-Prof2|Resto], Mejor) :-
    P1 < P2,
    mejor_resultado([P2-Prof2|Resto], Mejor).

recomendar_nombre(Evidencias, Nombre, Puntaje) :-
    recomendar(Evidencias, Profesion, Puntaje),
    nombre_profesion(Profesion, Nombre).