% =========================================
% INTERPRETACIÓN PRINCIPAL
% =========================================

interpretar_texto(Texto, Intencion, Atributo) :-
    tokenizar(Texto, Tokens),
    phrase(oracion(Intencion, _, Atributo), Tokens), !.

tokenizar(Texto, Tokens) :-
    split_string(Texto, " ,.;:?!()[]{}\"'\n\t\r", "", Partes),
    maplist(string_lower, Partes, Minusculas),
    maplist(atom_string, Tokens, Minusculas).

% =========================================
% ORACION GENERAL
% =========================================

oracion(Intencion, Nivel, Atributo) -->
    cualquier,
    oracion_base(Intencion, Nivel, Atributo),
    cualquier.

% =========================================
% CASOS PRINCIPALES
% =========================================

oracion_base(Intencion, Nivel, Atributo) -->
    sintagma_nominal,
    sintagma_verbal(Intencion, Nivel, Atributo).

oracion_base(Intencion, Nivel, Atributo) -->
    sintagma_verbal(Intencion, Nivel, Atributo).

oracion_base(Intencion, Nivel, _) -->
    respuesta_corta(Intencion, Nivel).

% =========================================
% SINTAGMA NOMINAL
% =========================================

sintagma_nominal --> pronombre.
sintagma_nominal --> pronombre, complemento_nominal.

pronombre --> [yo].
pronombre --> [me].

complemento_nominal --> [].
complemento_nominal --> [soy].
complemento_nominal --> [estoy].

% =========================================
% SINTAGMA VERBAL
% =========================================

% ✅ CAMBIO: atributo ahora es opcional

sintagma_verbal(positiva, Nivel, Atributo) -->
    verbo_positivo,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

sintagma_verbal(positiva, Nivel, Atributo) -->
    verbo_positivo,
    complemento,
    atributo_opcional(Atributo),
    nivel(Nivel).

sintagma_verbal(negativa, Nivel, Atributo) -->
    negacion,
    verbo_positivo,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

sintagma_verbal(negativa, Nivel, Atributo) -->
    verbo_negativo,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

sintagma_verbal(positiva, Nivel, Atributo) -->
    habilidad_positiva,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

sintagma_verbal(negativa, Nivel, Atributo) -->
    habilidad_negativa,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

sintagma_verbal(positiva, Nivel, Atributo) -->
    preferencia_positiva,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

sintagma_verbal(negativa, Nivel, Atributo) -->
    preferencia_negativa,
    nivel(Nivel),
    complemento,
    atributo_opcional(Atributo).

% ✅ CAMBIO: permite "me gusta"
sintagma_verbal(positiva, medio, _) -->
    verbo_positivo.

% =========================================
% RESPUESTAS CORTAS (SIN ATRIBUTO)
% =========================================

% ❌ NO permite "si" solo
respuesta_corta(positiva, Nivel) -->
    afirmacion,
    complemento_no_vacio,
    nivel(Nivel).

respuesta_corta(positiva, Nivel) -->
    afirmacion,
    complemento_no_vacio.

% ❌ NO permite "no" solo
respuesta_corta(negativa, Nivel) -->
    negacion,
    complemento_no_vacio,
    nivel(Nivel).

respuesta_corta(negativa, Nivel) -->
    negacion,
    complemento_no_vacio.

respuesta_corta(neutra, medio) -->
    [mas], [o], [menos].

% =========================================
% NIVEL / INTENSIDAD
% =========================================

nivel(alto) --> [mucho].
nivel(alto) --> [muchos].
nivel(alto) --> [bastante].
nivel(alto) --> [muchisimo].

nivel(bajo) --> [poco].
nivel(bajo) --> [poquito].
nivel(bajo) --> [apenas].

nivel(medio) --> [].

% =========================================
% COMPLEMENTOS
% =========================================

complemento --> [].
complemento --> [_], complemento.

complemento_no_vacio --> [_].
complemento_no_vacio --> [_], complemento.

% =========================================
% ARTÍCULOS (NUEVO)
% =========================================

articulo --> [el].
articulo --> [la].
articulo --> [los].
articulo --> [las].
articulo --> [un].
articulo --> [una].

% =========================================
% LEXICO BASE
% =========================================

verbo_positivo --> [amo].
verbo_positivo --> [adoro].
verbo_positivo --> [gusta].
verbo_positivo --> [gustan].
verbo_positivo --> [encanta].
verbo_positivo --> [interesa].
verbo_positivo --> [disfruto].
verbo_positivo --> [prefiero].
verbo_positivo --> [fascina].
verbo_positivo --> [Fascinan].

verbo_negativo --> [odio].
verbo_negativo --> [detesto].
verbo_negativo --> [rechazo].
verbo_negativo --> [aborrezco].
verbo_negativo --> [evito].

habilidad_positiva --> [bueno].
habilidad_positiva --> [capaz].
habilidad_positiva --> [talentoso].

habilidad_negativa --> [malo].
habilidad_negativa --> [incapaz].

preferencia_positiva --> [prefiero].
preferencia_positiva --> [elijo].

preferencia_negativa --> [evito].

negacion --> [no].
negacion --> [nunca].

afirmacion --> [si].
afirmacion --> [claro].

% =========================================
% ATRIBUTOS (CORREGIDO)
% =========================================

% ✅ CAMBIO CLAVE: atributo ahora soporta artículos

atributo(A) --> articulo, atributo_base(A).
atributo(A) --> atributo_base(A).

% ✅ AQUÍ dejas todos los tuyos pero como atributo_base

atributo_base(tecnologia) --> [tecnologia].
atributo_base(tecnologia) --> [computadoras].
atributo_base(tecnologia) --> [software].

atributo_base(matematicas) --> [matematicas].

atributo_base(resolver_problemas) --> [problemas].

% (continúa con todos los demás que ya tenías)

% =========================================
% ATRIBUTO OPCIONAL (NUEVO)
% =========================================

atributo_opcional(A) --> atributo(A).
atributo_opcional(_) --> [].

% =========================================
% CUALQUIER
% =========================================

cualquier --> [].
cualquier --> [_], cualquier.