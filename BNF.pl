% BNF.pl
%
% Parser basado en DCG (Definite Clause Grammars)
% para interpretar respuestas en lenguaje natural.
%
% Convierte texto ingresado por el usuario en:
%   Intencion: positiva | negativa
%   Nivel: alto | medio | bajo
%   Atributo: dominio semántico detectado
%
% Flujo:
% Texto -> tokenizar -> DCG (oracion) -> estructura semántica
%
% Ejemplo:
% "me gusta mucho la tecnologia"
% -> positiva, alto, tecnologia
%
% Este parser es tolerante a:
% - palabras de relleno
% - variaciones de orden
% - errores ortográficos simples


% =========================================
% INTERPRETACION PRINCIPAL
% =========================================

% Predicado principal del parser.
% Convierte texto en tokens y aplica la gramática DCG.
% Si encuentra una oración válida, retorna:
%   Intencion (positiva/negativa)
%   Nivel (alto/medio/bajo)
%   Atributo identificado
%
% El cut (!) evita multiples interpretaciones.

interpretar_texto(Texto, Intencion, Atributo) :-
    tokenizar(Texto, Tokens),
    phrase(oracion(Intencion, _, Atributo), Tokens), !.

% Convierte un string en una lista de tokens (átomos).
% - Separa por signos de puntuación
% - Convierte a minúsculas
% - Elimina tildes
tokenizar(Texto, Tokens) :-
    split_string(Texto, " ,.;:?!¿¡()[]{}\"'\n\t\r", "", Partes),
    maplist(normalizar_token, Partes, Tokens).


% Normaliza cada palabra:
% - Pasa a minúscula
% - Elimina tildes (á -> a, ñ -> n, etc.)
% - Convierte a átomo para uso en DCG
normalizar_token(Texto, Atom) :-
    string_lower(Texto, Minuscula),
    string_chars(Minuscula, Chars),
    maplist(quitar_tilde, Chars, Limpios),
    string_chars(SinTildes, Limpios),
    atom_string(Atom, SinTildes).


% Reglas para eliminar tildes y normalizar caracteres especiales.
quitar_tilde('á', 'a').
quitar_tilde('é', 'e').
quitar_tilde('í', 'i').
quitar_tilde('ó', 'o').
quitar_tilde('ú', 'u').
quitar_tilde('ü', 'u').
quitar_tilde('ñ', 'n').
quitar_tilde(C, C).

% =========================================
% ORACION GENERAL
% =========================================


% Regla principal de la gramática.
% Permite:
% - palabras de relleno al inicio y final
% - una oración base con contenido semántico
oracion(Intencion, Nivel, Atributo) -->
    relleno_inicial,
    oracion_base(Intencion, Nivel, Atributo),
    relleno_final.


% Permite ignorar palabras de relleno al inicio de la oración.
% Ej: "eh", "mmm", "bueno"
relleno_inicial --> [].
relleno_inicial --> palabra_relleno, relleno_inicial.

% Permite ignorar palabras de relleno al final de la oración.
relleno_final --> [].
relleno_final --> palabra_relleno, relleno_final.

palabra_relleno --> [eh].
palabra_relleno --> [mmm].
palabra_relleno --> [bueno].
palabra_relleno --> [pues].
palabra_relleno --> [correcto].

% =========================================
% CASOS PRINCIPALES
% =========================================


% Define las estructuras principales válidas de una oración:
% 1. Sintagma nominal + verbal
% 2. Solo sintagma verbal
% 3. Respuestas cortas
oracion_base(Intencion, Nivel, Atributo) -->
    sintagma_nominal,
    conectores,
    sintagma_verbal(Intencion, Nivel, Atributo).

oracion_base(Intencion, Nivel, Atributo) -->
    sintagma_verbal(Intencion, Nivel, Atributo).

oracion_base(Intencion, Nivel, Atributo) -->
    respuesta_corta(Intencion, Nivel, Atributo).

% =========================================
% SINTAGMA NOMINAL
% =========================================

% Representa el sujeto implícito del usuario.
% Ej: "yo", "me"
sintagma_nominal --> [yo].
sintagma_nominal --> [me].


% =========================================
% CONECTORES / PALABRAS INTERMEDIAS
% =========================================

% Permite palabras intermedias sin carga semántica fuerte.
% Facilita flexibilidad en la estructura de la oración.
conectores --> [].
conectores --> conector, conectores.

conector --> [trabajar].
conector --> [trabajando].
conector --> [estudiar].
conector --> [estudiando].
conector --> [pasar].
conector --> [frente].
conector --> [me].
conector --> [mi].
conector --> [mis].
conector --> [lo].
conector --> [la].
conector --> [los].
conector --> [las].
conector --> [el].
conector --> [al].
conector --> [un].
conector --> [una].
conector --> [unos].
conector --> [unas].
conector --> [a].
conector --> [de].
conector --> [del].
conector --> [con].
conector --> [por].
conector --> [para].
conector --> [en].
conector --> [que].
conector --> [y].
conector --> [o].

pronombre_objeto --> [lo].
pronombre_objeto --> [la].
pronombre_objeto --> [los].
pronombre_objeto --> [las].

pronombre_opcional --> [].
pronombre_opcional --> pronombre_objeto.

% =========================================
% SINTAGMA VERBAL
% =========================================
% Define las formas principales de expresar una intención:
%
% positiva:
%   - "me gusta X"
%   - "amo X"
%   - "soy bueno en X"
%
% negativa:
%   - "no me gusta X"
%   - "odio X"
%
% También maneja:
% - diferentes órdenes de palabras
% - niveles de intensidad
% - negaciones parciales

% Ej: me gusta la tecnologia
% Ej: amo mucho las matematicas
sintagma_verbal(positiva, Nivel, Atributo) -->
    verbo_positivo,
    conectores,
    nivel_opcional(Nivel),
    conectores,
    atributo(Atributo).

% Ej: me gusta la tecnologia mucho
sintagma_verbal(positiva, Nivel, Atributo) -->
    verbo_positivo,
    conectores,
    atributo(Atributo),
    conectores,
    nivel_opcional(Nivel).

% Ej: soy muy habil con la tecnologia
sintagma_verbal(positiva, Nivel, Atributo) -->
    estado_positivo(Nivel),
    conectores,
    atributo(Atributo).

% Ej: las matematicas me gustan
sintagma_verbal(positiva, Nivel, Atributo) -->
    atributo(Atributo),
    conectores,
    verbo_positivo,
    conectores,
    nivel_opcional(Nivel).

% Ej: no me gusta la tecnologia
sintagma_verbal(negativa, Nivel, Atributo) -->
    negacion,
    conectores,
    verbo_positivo,
    conectores,
    nivel_opcional(Nivel),
    conectores,
    atributo(Atributo).

% Ej: odio las personas
sintagma_verbal(negativa, Nivel, Atributo) -->
    verbo_negativo,
    conectores,
    nivel_opcional(Nivel),
    conectores,
    atributo(Atributo).

% Ej: detesto las ciencias mucho
sintagma_verbal(negativa, Nivel, Atributo) -->
    verbo_negativo,
    conectores,
    atributo(Atributo),
    conectores,
    nivel_opcional(Nivel).

% Ej: el area de salud la odio
sintagma_verbal(negativa, Nivel, Atributo) -->
    atributo(Atributo),
    conectores,
    pronombre_objeto,
    conectores,
    verbo_negativo,
    conectores,
    nivel_opcional(Nivel).

% Ej: no odio escribir
% Esto realmente indica una afinidad baja, no una negativa fuerte.
sintagma_verbal(positiva, bajo, Atributo) -->
    negacion,
    conectores,
    verbo_negativo,
    conectores,
    atributo(Atributo).

% =========================================
% RESPUESTAS CORTAS
% =========================================

% IMPORTANTE:
% "si" solo y "no" solo NO se aceptan.
% Esto coincide con el PDF, porque pide que no se acepte si/no directamente.

% Ej: si mucho
% Ej: si me gusta
% Ej: si me gustan
% Ej: si me gustan las personas
respuesta_corta(positiva, Nivel, Atributo) -->
    afirmacion,
    frase_positiva_corta(Nivel, Atributo).

% Ej: no mucho
% Ej: no me gusta
% Ej: no me gusta la tecnologia
respuesta_corta(negativa, Nivel, Atributo) -->
    negacion,
    frase_positiva_corta(Nivel, Atributo).

% Ej: mucho
% Ej: bastante
% Ej: me gusta
% Ej: me gustan
% Ej: me fascinan
respuesta_corta(positiva, Nivel, Atributo) -->
    frase_positiva_corta(Nivel, Atributo).

% Ej: la odio
% Ej: los evito
% Ej: odio conversar
respuesta_corta(negativa, Nivel, Atributo) -->
    frase_negativa_corta(Nivel, Atributo).

% Ej: no lo odio
% Se interpreta como afinidad baja, no como rechazo.
respuesta_corta(positiva, bajo, _) -->
    negacion,
    conectores,
    verbo_negativo,
    conectores.

% =========================================
% FRASES CORTAS
% =========================================

% Construye una interpretación positiva flexible:
% combina nivel, verbo y atributo opcional.
frase_positiva_corta(NivelFinal, Atributo) -->
    conectores,
    elemento_positivo(NivelBase),
    conectores,
    atributo_opcional(Atributo),
    conectores,
    nivel_final(NivelBase, NivelFinal),
    conectores.

% Construye una interpretación negativa con estructura flexible.
frase_negativa_corta(NivelFinal, Atributo) -->
    conectores,
    pronombre_opcional,
    conectores,
    verbo_negativo,
    conectores,
    atributo_opcional(Atributo),
    conectores,
    nivel_final(medio, NivelFinal),
    conectores.

elemento_positivo(Nivel) -->
    nivel(Nivel).

elemento_positivo(medio) -->
    verbo_positivo.

elemento_positivo(medio) -->
    verbo_ser.

elemento_positivo(medio) -->
    cualidad_positiva.

atributo_opcional(Atributo) -->
    atributo(Atributo).

atributo_opcional(_) -->
    tema_conocido.

atributo_opcional(_) -->
    [].

tema_conocido --> [conversar].
tema_conocido --> [charlar].
tema_conocido --> [trabajar].
tema_conocido --> [estudiar].

nivel_final(_, Nivel) -->
    nivel(Nivel).

nivel_final(Nivel, Nivel) -->
    [].

% =========================================
% NIVEL
% =========================================
% Define el nivel de intensidad de la respuesta:
% alto, medio o bajo.

nivel(alto) --> [mucho].
nivel(alto) --> [bastante].
nivel(alto) --> [muchisimo].
nivel(alto) --> [demasiado].
nivel(alto) --> [muy].

nivel(medio) --> [algo].
nivel(medio) --> [regular].

nivel(bajo) --> [poco].
nivel(bajo) --> [apenas].

% Permite que el nivel no esté explícito.
% Por defecto se asume nivel medio.
nivel_opcional(Nivel) -->
    nivel(Nivel).

nivel_opcional(medio) -->
    [].

% =========================================
% LEXICO POSITIVO
% =========================================
% Verbos que indican afinidad o gusto.
verbo_positivo --> [gusta].
verbo_positivo --> [gustan].
verbo_positivo --> [encanta].
verbo_positivo --> [encantan].
verbo_positivo --> [interesa].
verbo_positivo --> [interesan].
verbo_positivo --> [adoro].
verbo_positivo --> [amo].
verbo_positivo --> [disfruto].
verbo_positivo --> [prefiero].
verbo_positivo --> [fascina].
verbo_positivo --> [fascinan].
verbo_positivo --> [intereso].
verbo_positivo --> [agrada].
verbo_positivo --> [agradan].
verbo_positivo --> [gustaria].
verbo_positivo --> [quiero].

% Error ortografico comun: "facinan"
verbo_positivo --> [facina].
verbo_positivo --> [facinan].


% Verbos que indican rechazo o desagrado.
verbo_negativo --> [odio].
verbo_negativo --> [detesto].
verbo_negativo --> [evito].
verbo_negativo --> [rechazo].
verbo_negativo --> [aborrezco].
verbo_negativo --> [desagrada].
verbo_negativo --> [desagradan].
verbo_negativo --> [molesta].
verbo_negativo --> [molestan].


verbo_ser --> [soy].
verbo_ser --> [es].
verbo_ser --> [son].


% Expresiones de habilidad o cualidad positiva.
% Ej: "soy muy habil"
estado_positivo(Nivel) -->
    verbo_ser,
    intensidad_opcional(Nivel),
    cualidad_positiva.

intensidad_opcional(alto) -->
    intensidad_alta.

intensidad_opcional(medio) -->
    [].

intensidad_alta --> [muy].
intensidad_alta --> [bastante].

cualidad_positiva --> [habil].
cualidad_positiva --> [bueno].
cualidad_positiva --> [buena].
cualidad_positiva --> [creativo].
cualidad_positiva --> [creativa].

% Palabras que indican negación.
negacion --> [no].
negacion --> [nunca].
negacion --> [jamas].


% Palabras que indican afirmación.
afirmacion --> [si].
afirmacion --> [claro].
afirmacion --> [correcto].
afirmacion --> [afirmativo].

% =========================================
% ATRIBUTOS
% =========================================
% Mapea palabras del lenguaje natural a atributos del sistema.
% Cada atributo representa un área de interés o habilidad.
%
% Ejemplo:
% "computadoras" -> tecnologia
% "mate" -> matematicas

atributo(tecnologia) --> [tecnologia].
atributo(tecnologia) --> [computadoras].
atributo(tecnologia) --> [computador].
atributo(tecnologia) --> [programacion].

atributo(matematicas) --> [matematicas].
atributo(matematicas) --> [mate].
atributo(matematicas) --> [mates].

atributo(resolver_problemas) --> [problemas].
atributo(resolver_problemas) --> [resolver, problemas].
atributo(resolver_problemas) --> [solucionar, problemas].

atributo(personas) --> [personas].
atributo(personas) --> [gente].

atributo(escuchar) --> [escuchar].
atributo(escuchar) --> [escuchando].

atributo(ayudar) --> [ayudar].
atributo(ayudar) --> [ayudo].

atributo(salud) --> [salud].
atributo(salud) --> [area, salud].
atributo(salud) --> [area, de, salud].
atributo(salud) --> [el, area, salud].
atributo(salud) --> [el, area, de, salud].

atributo(ciencias) --> [ciencias].
atributo(ciencias) --> [ciencia].

atributo(justicia) --> [justicia].

atributo(argumentar) --> [argumentar].
atributo(argumentar) --> [defender].
atributo(argumentar) --> [defender, ideas].

atributo(negocios) --> [negocios].
atributo(negocios) --> [empresa].
atributo(negocios) --> [empresas].

atributo(liderazgo) --> [liderar].
atributo(liderazgo) --> [liderazgo].
atributo(liderazgo) --> [equipos].

atributo(creatividad) --> [creatividad].
atributo(creatividad) --> [creativo].
atributo(creatividad) --> [creativa].

atributo(arte) --> [arte].

atributo(ensenar) --> [ensenar].
atributo(ensenar) --> [explicar].
atributo(ensenar) --> [temas].

atributo(dibujo) --> [dibujar].
atributo(dibujo) --> [disenar].
atributo(dibujo) --> [dibujo].
atributo(dibujo) --> [diseno].

atributo(numeros) --> [numeros].
atributo(numeros) --> [numero].

atributo(finanzas) --> [finanzas].
atributo(finanzas) --> [dinero].

atributo(hablar) --> [hablar].
atributo(hablar) --> [expresarme].
atributo(hablar) --> [expresarse].
atributo(hablar) --> [publico].

atributo(escribir) --> [escribir].
atributo(escribir) --> [escritura].