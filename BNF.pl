interpretar_texto(Texto, Intencion, Atributo) :-
    tokenizar(Texto, Tokens),
    phrase(oracion(Intencion, Atributo), Tokens), !.

tokenizar(Texto, Tokens) :-
    split_string(Texto, " ,.;:?!()[]{}\"'\n\t\r", "", Partes),
    maplist(string_lower, Partes, Minusculas),
    maplist(atom_string, Tokens, Minusculas).

oracion(Intencion, Atributo) -->
    cualquier,
    oracion_base(Intencion, Atributo),
    cualquier.

oracion_base(Intencion, Atributo) -->
    sintagma_nominal,
    sintagma_verbal(Intencion, Atributo).

expresion(positiva, Atributo) -->
    afirmacion,
    cualquier,
    verbo_positivo,
    cualquier,
    atributo(Atributo).


verbo_positivo --> [amo].
verbo_positivo --> [adoro].
verbo_positivo --> [gusta].
verbo_positivo --> [gustan].
verbo_positivo --> [encanta].
verbo_positivo --> [encantan].
verbo_positivo --> [interesa].
verbo_positivo --> [interesan].
verbo_positivo --> [disfruto].
verbo_positivo --> [prefiero].
verbo_positivo --> [quiero].
verbo_positivo --> [apasiona].
verbo_positivo --> [apasionan].
verbo_positivo --> [aprecio].
verbo_positivo --> [valoro].
verbo_positivo --> [estimo].
verbo_positivo --> [busco].
verbo_positivo --> [deseo].
verbo_positivo --> [anhelo].
verbo_positivo --> [elijo].
verbo_positivo --> [selecciono].
verbo_positivo --> [necesito].
verbo_positivo --> [domino].
verbo_positivo --> [entiendo].
verbo_positivo --> [comprendo].
verbo_positivo --> [conozco].
verbo_positivo --> [manejo].
verbo_positivo --> [aspiro].

verbo_negativo --> [odio].
verbo_negativo --> [detesto].
verbo_negativo --> [rechazo].
verbo_negativo --> [aborrezco].
verbo_negativo --> [desagrado].
verbo_negativo --> [desagrada].

verbo_negativo --> [evito].
verbo_negativo --> [descarto].
verbo_negativo --> [rechazaria].
verbo_negativo --> [evitaria].
verbo_negativo --> [aburren].
verbo_negativo --> [aburre].
verbo_negativo --> [molesta].
verbo_negativo --> [molestan].
verbo_negativo --> [fastidia].
verbo_negativo --> [fastidian].
verbo_negativo --> [harto].
verbo_negativo --> [harta].
verbo_negativo --> [repelo].
verbo_negativo --> [repudia].
verbo_negativo --> [repudio].
verbo_negativo --> [indigna].
verbo_negativo --> [asquea].
verbo_negativo --> [disgustan].
verbo_negativo --> [disgusta].
verbo_negativo --> [choco].
verbo_negativo --> [choca].
verbo_negativo --> [ignoro].
verbo_negativo --> [desconozco].
verbo_negativo --> [dificulta].
verbo_negativo --> [complica].
verbo_negativo --> [atesta].
verbo_negativo --> [agobia].
verbo_negativo --> [agobian].
verbo_negativo --> [estresa].
verbo_negativo --> [estresan].
verbo_negativo --> [cansa].
verbo_negativo --> [cansan].

negacion --> [no].
negacion --> [nunca].
negacion --> [jamas].
negacion --> [tampoco].
negacion --> [ni].

afirmacion --> [si].
afirmacion --> [claro].
afirmacion --> [correcto].
afirmacion --> [exacto].
afirmacion --> [afirmativo].
afirmacion --> [definitivamente].

habilidad_positiva --> [habil].
habilidad_positiva --> [bueno].
habilidad_positiva --> [buena].
habilidad_positiva --> [capaz].
habilidad_positiva --> [talentoso].
habilidad_positiva --> [talentosa].
habilidad_positiva --> [facil].
habilidad_positiva --> [fuerte].

habilidad_negativa --> [malo].
habilidad_negativa --> [mala].
habilidad_negativa --> [debil].
habilidad_negativa --> [pesimo].
habilidad_negativa --> [pesima].
habilidad_negativa --> [incapaz].

preferencia_positiva --> [prefiero].
preferencia_positiva --> [elijo].
preferencia_positiva --> [busco].

preferencia_negativa --> [evito].
preferencia_negativa --> [descarto].

atributo(tecnologia) --> [tecnologia].
atributo(tecnologia) --> [computadoras].
atributo(tecnologia) --> [computadora].
atributo(tecnologia) --> [programacion].
atributo(tecnologia) --> [software].
atributo(tecnologia) --> [computadores].
atributo(tecnologia) --> [informatica].
atributo(tecnologia) --> [sistemas].

atributo(matematicas) --> [matematicas].
atributo(matematicas) --> [mate].
atributo(matematicas) --> [calculo].

atributo(resolver_problemas) --> [problemas].
atributo(resolver_problemas) --> [retos].
atributo(resolver_problemas) --> [soluciones].

atributo(logica) --> [logica].
atributo(logica) --> [razonamiento].

atributo(personas) --> [personas].
atributo(personas) --> [gente].
atributo(personas) --> [humanos].
atributo(personas) --> [pacientes].
atributo(personas) --> [clientes].
atributo(personas) --> [psicologia].
atributo(personas) --> [psicologo].
atributo(personas) --> [psicologa].

atributo(escuchar) --> [escuchar].
atributo(escuchar) --> [escucho].
atributo(escuchar) --> [atender].
atributo(escuchar) --> [comprender].

atributo(ayudar) --> [ayudar].
atributo(ayudar) --> [apoyar].
atributo(ayudar) --> [servir].

atributo(conducta_humana) --> [conducta].
atributo(conducta_humana) --> [mente].
atributo(conducta_humana) --> [emociones].
atributo(conducta_humana) --> [comportamiento].

atributo(salud) --> [salud].
atributo(salud) --> [medicina].
atributo(salud) --> [hospitales].
atributo(salud) --> [enfermedades].
atributo(salud) --> [medico].
atributo(salud) --> [medica].
atributo(salud) --> [doctor].
atributo(salud) --> [doctora].

atributo(ciencias) --> [ciencias].
atributo(ciencias) --> [biologia].
atributo(ciencias) --> [quimica].

atributo(justicia) --> [justicia].
atributo(justicia) --> [leyes].
atributo(justicia) --> [derecho].
atributo(justicia) --> [abogado].
atributo(justicia) --> [abogada].
atributo(justicia) --> [tribunales].

atributo(argumentar) --> [argumentar].
atributo(argumentar) --> [debatir].
atributo(argumentar) --> [defender].

atributo(leer) --> [leer].
atributo(leer) --> [lectura].
atributo(leer) --> [libros].

atributo(resolver_conflictos) --> [conflictos].
atributo(resolver_conflictos) --> [discusiones].
atributo(resolver_conflictos) --> [negociaciones].

atributo(negocios) --> [negocios].
atributo(negocios) --> [empresas].
atributo(negocios) --> [emprendimientos].
atributo(negocios) --> [administracion].
atributo(negocios) --> [gerencia].
atributo(negocios) --> [empresa].

atributo(liderazgo) --> [liderazgo].
atributo(liderazgo) --> [liderar].
atributo(liderazgo) --> [dirigir].

atributo(organizacion) --> [organizacion].
atributo(organizacion) --> [ordenar].
atributo(organizacion) --> [planear].

atributo(toma_decisiones) --> [decisiones].
atributo(toma_decisiones) --> [decidir].

atributo(creatividad) --> [creatividad].
atributo(creatividad) --> [creativo].
atributo(creatividad) --> [creativa].
atributo(creatividad) --> [crear].

atributo(arte) --> [arte].
atributo(arte) --> [artistico].
atributo(arte) --> [pintura].

atributo(comunicacion_visual) --> [visual].
atributo(comunicacion_visual) --> [imagenes].

atributo(innovacion) --> [innovacion].
atributo(innovacion) --> [innovar].

atributo(ensenar) --> [ensenar].
atributo(ensenar) --> [educar].
atributo(ensenar) --> [clases].
atributo(ensenar) --> [docencia].
atributo(ensenar) --> [profesor].
atributo(ensenar) --> [profesora].

atributo(explicar) --> [explicar].
atributo(explicar) --> [explico].
atributo(explicar) --> [ensenar].

atributo(aprendizaje) --> [aprender].
atributo(aprendizaje) --> [aprendizaje].
atributo(aprendizaje) --> [estudiar].

atributo(diseno) --> [diseno].
atributo(diseno) --> [disenar].
atributo(diseno) --> [arquitectura].
atributo(diseno) --> [arquitecto].
atributo(diseno) --> [arquitecta].

atributo(espacios) --> [espacios].
atributo(espacios) --> [edificios].
atributo(espacios) --> [casas].

atributo(dibujo) --> [dibujo].
atributo(dibujo) --> [dibujar].
atributo(dibujo) --> [planos].

atributo(numeros) --> [numeros].
atributo(numeros) --> [cuentas].
atributo(numeros) --> [calculos].

atributo(orden) --> [orden].
atributo(orden) --> [ordenado].
atributo(orden) --> [ordenada].

atributo(finanzas) --> [finanzas].
atributo(finanzas) --> [dinero].
atributo(finanzas) --> [contabilidad].
atributo(finanzas) --> [contador].
atributo(finanzas) --> [contadora].

atributo(analisis) --> [analisis].
atributo(analisis) --> [analizar].

atributo(hablar) --> [hablar].
atributo(hablar) --> [conversar].
atributo(hablar) --> [exponer].

atributo(escribir) --> [escribir].
atributo(escribir) --> [redactar].
atributo(escribir) --> [textos].

atributo(medios) --> [medios].
atributo(medios) --> [redes].
atributo(medios) --> [noticias].
atributo(medios) --> [comunicacion].
atributo(medios) --> [periodismo].

cualquier --> [].
cualquier --> [_], cualquier.

interpretar_texto(Texto, Intencion, Atributo) :-
    tokenizar(Texto, Tokens),
    phrase(oracion(Intencion, Atributo), Tokens), !.

tokenizar(Texto, Tokens) :-
    split_string(Texto, " ,.;:?!()[]{}\"'\n\t\r", "", Partes),
    maplist(string_lower, Partes, Minusculas),
    maplist(atom_string, Tokens, Minusculas).

% ----------------------------
% ORACION PRINCIPAL
% ----------------------------

oracion(Intencion, Atributo) -->
    cualquier,
    oracion_base(Intencion, Atributo),
    cualquier.

% ----------------------------
% ESTRUCTURA FORMAL (LO QUE TE FALTABA)
% ----------------------------

% Caso completo: SN + SV
oracion_base(Intencion, Atributo) -->
    sintagma_nominal,
    sintagma_verbal(Intencion, Atributo).

% Caso sin sujeto (muy común en lenguaje natural)
oracion_base(Intencion, Atributo) -->
    sintagma_verbal(Intencion, Atributo).

% Caso tipo: "no mucho la tecnologia"
oracion_base(negativa, Atributo) -->
    negacion,
    cualquier,
    atributo(Atributo).

% ----------------------------
% SINTAGMA NOMINAL
% ----------------------------

sintagma_nominal -->
    pronombre.

sintagma_nominal -->
    pronombre,
    complemento_nominal.

pronombre --> [yo].
pronombre --> [me].

complemento_nominal --> [].
complemento_nominal --> [soy].
complemento_nominal --> [estoy].

% ----------------------------
% SINTAGMA VERBAL
% ----------------------------

sintagma_verbal(positiva, Atributo) -->
    verbo_positivo,
    complemento,
    atributo(Atributo).

sintagma_verbal(positiva, Atributo) -->
    habilidad_positiva,
    complemento,
    atributo(Atributo).

sintagma_verbal(positiva, Atributo) -->
    preferencia_positiva,
    complemento,
    atributo(Atributo).

sintagma_verbal(negativa, Atributo) -->
    negacion,
    verbo_positivo,
    complemento,
    atributo(Atributo).

sintagma_verbal(negativa, Atributo) -->
    verbo_negativo,
    complemento,
    atributo(Atributo).

sintagma_verbal(negativa, Atributo) -->
    negacion,
    habilidad_positiva,
    complemento,
    atributo(Atributo).


complemento --> [].
complemento --> [_], complemento.


cualquier --> [].
cualquier --> [_], cualquier.