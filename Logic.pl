% Sistema experto orientador de carreras
%
% Este sistema recomienda una profesión basada en evidencias
% positivas y negativas proporcionadas por el usuario.
%
% Flujo general:
% 1. Se recolectan evidencias mediante preguntas
% 2. Se calcula un puntaje para cada profesión
% 3. Se selecciona la profesión con mejor puntaje
% 4. Se muestra la recomendación al usuario
%
% Dependencias:
% BD.pl:
%   - profesion/1
%   - afinidad/2
%   - fortaleza/2
%   - antagonia/2
%   - nombre_profesion/2
%
% BNF.pl:
%   - pregunta/2
%   - interpretar_texto/3

:- consult('BD.pl').

% Calcula el puntaje total de una profesión dada una lista de evidencias.
% Inicializa el acumulador en 0 y procesa cada evidencia.
puntaje_profesion(Profesion, Evidencias, Puntaje) :-
    profesion(Profesion),
    puntaje_lista(Profesion, Evidencias, 0, Puntaje).

% Procesa una evidencia positiva de la forma positiva(Atributo).
% Calcula el puntaje correspondiente y lo suma al acumulado.
puntaje_lista(_, [], Puntaje, Puntaje).

% Procesa una evidencia positiva de la forma positiva(Atributo).
% Si el atributo tiene afinidad o fortaleza con la profesión,
% se suman puntos al acumulado.
puntaje_lista(Profesion, [positiva(Atributo)|Resto], Acumulado, Puntaje) :-
    puntaje_positivo(Profesion, Atributo, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

% Procesa una evidencia negativa de la forma negativa(Atributo).
% Calcula el puntaje negativo correspondiente y lo suma al acumulado.
puntaje_lista(Profesion, [negativa(Atributo)|Resto], Acumulado, Puntaje) :-
    puntaje_negativo(Profesion, Atributo, Puntos),
    NuevoAcumulado is Acumulado + Puntos,
    puntaje_lista(Profesion, Resto, NuevoAcumulado, Puntaje).

% Reglas de puntaje:
% Evidencia positiva:
%   - Afinidad: +2 puntos
%   - Fortaleza: +1 punto
%   - Ninguna: 0 puntos
%
% Evidencia negativa:
%   - Antagonía: -3 puntos
%   - Afinidad: -2 puntos
%   - Ninguna: 0 puntos

puntaje_positivo(Profesion, Atributo, 2) :-
    afinidad(Profesion, Atributo), !. % cut: evita evaluar otras reglas

puntaje_positivo(Profesion, Atributo, 1) :-
    fortaleza(Profesion, Atributo), !. % cut: evita evaluar otras reglas

puntaje_positivo(_, _, 0).

% Calcula puntos para evidencia negativa: -3 si antagonía, -2 si afinidad, 0 si nada
puntaje_negativo(Profesion, Atributo, -3) :-
    opuesto(Atributo, Antagonia),
    antagonia(Profesion, Antagonia), !. % cut: evita evaluar otras reglas

puntaje_negativo(Profesion, Atributo, -2) :-
    afinidad(Profesion, Atributo), !. % cut: evita evaluar otras reglas

puntaje_negativo(_, _, 0).

% Genera una lista de pares Puntaje-Profesion para todas las profesiones
% y selecciona la mejor según el puntaje.

recomendar(Evidencias, Profesion, Puntaje) :-
    findall(P-Prof, puntaje_profesion(Prof, Evidencias, P), Resultados),
    mejor_resultado(Resultados, Puntaje-Profesion).

% Determina el par Puntaje-Profesion con mayor puntaje en la lista.
% Compara recursivamente elementos de dos en dos.
mejor_resultado([Resultado], Resultado).

% Caso recursivo: compara el primer elemento con el resto
mejor_resultado([P1-Prof1, P2-Prof2|Resto], Mejor) :-
    P1 >= P2,
    mejor_resultado([P1-Prof1|Resto], Mejor).

mejor_resultado([P1-_, P2-Prof2|Resto], Mejor) :-
    P1 < P2,
    mejor_resultado([P2-Prof2|Resto], Mejor).

% Recomienda la profesión con nombre basado en evidencias
recomendar_nombre(Evidencias, Nombre, Puntaje) :-
    recomendar(Evidencias, Profesion, Puntaje),
    nombre_profesion(Profesion, Nombre).

:- consult('BNF.pl').

% Punto de entrada del sistema.
% Ejecuta todo el flujo: recolección de evidencias y recomendación final.
iniciar :-
    recolectar_evidencias(Evidencias),
    recomendar_nombre(Evidencias, Nombre, Puntaje),
    nl,
    write('Segun tus respuestas, te recomiendo: '), nl,
    write(Nombre), nl,
    write('Puntaje: '), write(Puntaje), nl.

% Obtiene todos los atributos definidos en pregunta/2
% y consulta al usuario uno por uno.
recolectar_evidencias(Evidencias) :-
    findall(Atributo, pregunta(Atributo, _), Atributos),
    preguntar_lista(Atributos, Evidencias).

% Recorre la lista de atributos, mostrando cada pregunta al usuario.
% Interpreta la respuesta como positiva o negativa.
% Si no se entiende la respuesta, repite la misma pregunta.
preguntar_lista([], []).

% Caso recursivo: pregunta por un atributo y procesa la respuesta
preguntar_lista([Attr|Resto], [Evidencia|Evs]) :-
    pregunta(Attr, Texto),
    nl,
    write(Texto), nl,
    read_line_to_string(user_input, Input),


    % interpretar_texto/3 determina si la respuesta del usuario
    % corresponde a una evidencia positiva o negativa.
    (
        interpretar_texto(Input, Intencion, Attr)
        ->
        Evidencia =.. [Intencion, Attr],
        preguntar_lista(Resto, Evs)
        ;
        write('No entendi, intenta otra vez.'), nl,
        preguntar_lista([Attr|Resto], [Evidencia|Evs])
    ).

    