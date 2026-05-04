:- consult('BD.pl').

puntaje_profesion(Profesion, Evidencias, Puntaje) :-
    profesion(Profesion),
    puntaje_lista(Profesion, Evidencias, 0, Puntaje).

puntaje_lista(_, [], Puntaje, Puntaje) :- !.

puntaje_lista(Profesion, [positiva(Atributo)|Resto], Acumulado, Puntaje) :-
    !,
    puntaje_positivo(Profesion, Atributo, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

puntaje_lista(Profesion, [negativa(Atributo)|Resto], Acumulado, Puntaje) :-
    !,
    puntaje_negativo(Profesion, Atributo, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

puntaje_lista(Profesion, [positiva(Atributo, Nivel)|Resto], Acumulado, Puntaje) :-
    !,
    puntaje_positivo(Profesion, Atributo, Base),
    ajustar_por_nivel(Base, Nivel, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

puntaje_lista(Profesion, [negativa(Atributo, Nivel)|Resto], Acumulado, Puntaje) :-
    !,
    puntaje_negativo(Profesion, Atributo, Base),
    ajustar_por_nivel(Base, Nivel, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

puntaje_lista(Profesion, [_|Resto], Acumulado, Puntaje) :-
    !,
    puntaje_lista(Profesion, Resto, Acumulado, Puntaje).

puntaje_positivo(Profesion, Atributo, 2) :-
    afinidad(Profesion, Atributo),
    !.

puntaje_positivo(Profesion, Atributo, 1) :-
    fortaleza(Profesion, Atributo),
    !.

puntaje_positivo(_, _, 0).

puntaje_negativo(Profesion, Atributo, -3) :-
    opuesto(Atributo, Antagonia),
    antagonia(Profesion, Antagonia),
    !.

puntaje_negativo(Profesion, Atributo, -2) :-
    afinidad(Profesion, Atributo),
    !.

puntaje_negativo(_, _, 0).

ajustar_por_nivel(Puntos, alto, Ajustado) :-
    !,
    Ajustado is Puntos * 2.

ajustar_por_nivel(Puntos, medio, Puntos) :-
    !.

ajustar_por_nivel(Puntos, bajo, Ajustado) :-
    !,
    Ajustado is Puntos // 2.

ajustar_por_nivel(Puntos, _, Puntos) :-
    !.

recomendar(Evidencias, Profesion, Puntaje) :-
    findall(P-Prof, puntaje_profesion(Prof, Evidencias, P), Resultados),
    mejor_resultado(Resultados, Puntaje-Profesion).

mejor_resultado([Resultado], Resultado) :-
    !.

mejor_resultado([P1-Prof1, P2-_|Resto], Mejor) :-
    P1 >= P2,
    !,
    mejor_resultado([P1-Prof1|Resto], Mejor).

mejor_resultado([_-_, P2-Prof2|Resto], Mejor) :-
    !,
    mejor_resultado([P2-Prof2|Resto], Mejor).

recomendar_nombre(Evidencias, Nombre, Puntaje) :-
    recomendar(Evidencias, Profesion, Puntaje),
    nombre_profesion(Profesion, Nombre).

:- consult('BNF.pl').

iniciar :-
    nl,
    write('Hola, se que la tarea de buscar una carrera es dificil.'), nl,
    write('Estamos aqui para ayudarte.'), nl,
    recolectar_evidencias(Evidencias),
    recomendar_nombre(Evidencias, Nombre, Puntaje),
    nl,
    write('Segun tus respuestas, te recomiendo: '), nl,
    write(Nombre), nl,
    write('Puntaje: '), write(Puntaje), nl.

recolectar_evidencias(Evidencias) :-
    findall(Atributo, pregunta(Atributo, _), Atributos),
    preguntar_lista(Atributos, Evidencias).

preguntar_lista([], []) :- !.

preguntar_lista([Attr|Resto], [Evidencia|Evs]) :-
    pregunta(Attr, Texto),
    nl,
    write(Texto), nl,
    read_line_to_string(user_input, Input),
    (
        interpretar_texto(Input, Intencion, Nivel, Attr)
        ->
        Evidencia =.. [Intencion, Attr, Nivel],
        preguntar_lista(Resto, Evs)
        ;
        interpretar_texto(Input, Intencion, Attr)
        ->
        Evidencia =.. [Intencion, Attr],
        preguntar_lista(Resto, Evs)
        ;
        write('No entendi, intenta otra vez.'), nl,
        preguntar_lista([Attr|Resto], [Evidencia|Evs])
    ).