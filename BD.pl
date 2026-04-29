profesion(ingenieria_computadores).
profesion(psicologia).
profesion(medicina).
profesion(derecho).
profesion(administracion).
profesion(diseno).
profesion(docencia).
profesion(arquitectura).
profesion(contabilidad).
profesion(comunicacion).

nombre_profesion(ingenieria_computadores, 'Ingenieria en Computadores').
nombre_profesion(psicologia, 'Psicologia').
nombre_profesion(medicina, 'Medicina').
nombre_profesion(derecho, 'Derecho').
nombre_profesion(administracion, 'Administracion').
nombre_profesion(diseno, 'Diseno').
nombre_profesion(docencia, 'Docencia').
nombre_profesion(arquitectura, 'Arquitectura').
nombre_profesion(contabilidad, 'Contabilidad').
nombre_profesion(comunicacion, 'Comunicacion').

afinidad(ingenieria_computadores, tecnologia).
afinidad(ingenieria_computadores, matematicas).
afinidad(ingenieria_computadores, resolver_problemas).
afinidad(ingenieria_computadores, logica).

afinidad(psicologia, personas).
afinidad(psicologia, escuchar).
afinidad(psicologia, ayudar).
afinidad(psicologia, conducta_humana).

afinidad(medicina, salud).
afinidad(medicina, ayudar).
afinidad(medicina, ciencias).
afinidad(medicina, personas).

afinidad(derecho, justicia).
afinidad(derecho, argumentar).
afinidad(derecho, leer).
afinidad(derecho, resolver_conflictos).

afinidad(administracion, negocios).
afinidad(administracion, liderazgo).
afinidad(administracion, organizacion).
afinidad(administracion, toma_decisiones).

afinidad(diseno, creatividad).
afinidad(diseno, arte).
afinidad(diseno, comunicacion_visual).
afinidad(diseno, innovacion).

afinidad(docencia, ensenar).
afinidad(docencia, personas).
afinidad(docencia, explicar).
afinidad(docencia, aprendizaje).

afinidad(arquitectura, diseno).
afinidad(arquitectura, creatividad).
afinidad(arquitectura, espacios).
afinidad(arquitectura, dibujo).

afinidad(contabilidad, numeros).
afinidad(contabilidad, orden).
afinidad(contabilidad, finanzas).
afinidad(contabilidad, analisis).

afinidad(comunicacion, hablar).
afinidad(comunicacion, escribir).
afinidad(comunicacion, medios).
afinidad(comunicacion, creatividad).

fortaleza(ingenieria_computadores, pensamiento_logico).
fortaleza(ingenieria_computadores, programacion).
fortaleza(ingenieria_computadores, analisis).
fortaleza(ingenieria_computadores, abstraccion).

fortaleza(psicologia, empatia).
fortaleza(psicologia, escucha_activa).
fortaleza(psicologia, observacion).
fortaleza(psicologia, comunicacion).

fortaleza(medicina, disciplina).
fortaleza(medicina, memoria).
fortaleza(medicina, analisis).
fortaleza(medicina, responsabilidad).

fortaleza(derecho, argumentacion).
fortaleza(derecho, lectura).
fortaleza(derecho, comunicacion).
fortaleza(derecho, pensamiento_critico).

fortaleza(administracion, liderazgo).
fortaleza(administracion, planificacion).
fortaleza(administracion, organizacion).
fortaleza(administracion, negociacion).

fortaleza(diseno, creatividad).
fortaleza(diseno, estetica).
fortaleza(diseno, dibujo).
fortaleza(diseno, imaginacion).

fortaleza(docencia, paciencia).
fortaleza(docencia, comunicacion).
fortaleza(docencia, explicar).
fortaleza(docencia, empatia).

fortaleza(arquitectura, dibujo).
fortaleza(arquitectura, vision_espacial).
fortaleza(arquitectura, creatividad).
fortaleza(arquitectura, planificacion).

fortaleza(contabilidad, orden).
fortaleza(contabilidad, precision).
fortaleza(contabilidad, analisis).
fortaleza(contabilidad, numeros).

fortaleza(comunicacion, expresion_oral).
fortaleza(comunicacion, escritura).
fortaleza(comunicacion, creatividad).
fortaleza(comunicacion, socializacion).

antagonia(ingenieria_computadores, desinteres_tecnologia).
antagonia(ingenieria_computadores, rechazo_matematicas).
antagonia(ingenieria_computadores, rechazo_logica).

antagonia(psicologia, desinteres_personas).
antagonia(psicologia, rechazo_escuchar).
antagonia(psicologia, poca_empatia).

antagonia(medicina, desinteres_salud).
antagonia(medicina, rechazo_ciencias).
antagonia(medicina, poca_disciplina).

antagonia(derecho, rechazo_leer).
antagonia(derecho, rechazo_argumentar).
antagonia(derecho, desinteres_justicia).

antagonia(administracion, rechazo_liderazgo).
antagonia(administracion, desinteres_negocios).
antagonia(administracion, desorganizacion).

antagonia(diseno, rechazo_creatividad).
antagonia(diseno, desinteres_arte).
antagonia(diseno, rechazo_dibujo).

antagonia(docencia, rechazo_ensenar).
antagonia(docencia, poca_paciencia).
antagonia(docencia, desinteres_personas).

antagonia(arquitectura, rechazo_dibujo).
antagonia(arquitectura, rechazo_diseno).
antagonia(arquitectura, poca_creatividad).

antagonia(contabilidad, rechazo_numeros).
antagonia(contabilidad, desorden).
antagonia(contabilidad, desinteres_finanzas).

antagonia(comunicacion, rechazo_hablar).
antagonia(comunicacion, rechazo_escribir).
antagonia(comunicacion, poca_socializacion).

pregunta(tecnologia, 'Te gusta la tecnologia?').
pregunta(matematicas, 'Te gustan las matematicas?').
pregunta(resolver_problemas, 'Te gusta resolver problemas?').
pregunta(personas, 'Tienes interes por las personas?').
pregunta(escuchar, 'Cuando conversas con los demas, prefieres escuchar?').
pregunta(ayudar, 'Te gusta ayudar a otras personas?').
pregunta(salud, 'Te interesa el area de la salud?').
pregunta(ciencias, 'Te gustan las ciencias?').
pregunta(justicia, 'Te interesa la justicia?').
pregunta(argumentar, 'Te gusta argumentar o defender ideas?').
pregunta(negocios, 'Te interesan los negocios?').
pregunta(liderazgo, 'Te gusta liderar equipos?').
pregunta(creatividad, 'Te consideras una persona creativa?').
pregunta(arte, 'Te interesa el arte?').
pregunta(ensenar, 'Te gusta ensenar o explicar temas?').
pregunta(dibujo, 'Te gusta dibujar o disenar?').
pregunta(numeros, 'Te sientes comodo trabajando con numeros?').
pregunta(finanzas, 'Te interesan las finanzas?').
pregunta(hablar, 'Te gusta hablar y expresarte frente a otras personas?').
pregunta(escribir, 'Te gusta escribir?').

opuesto(tecnologia, desinteres_tecnologia).
opuesto(matematicas, rechazo_matematicas).
opuesto(logica, rechazo_logica).
opuesto(personas, desinteres_personas).
opuesto(escuchar, rechazo_escuchar).
opuesto(empatia, poca_empatia).
opuesto(salud, desinteres_salud).
opuesto(ciencias, rechazo_ciencias).
opuesto(disciplina, poca_disciplina).
opuesto(leer, rechazo_leer).
opuesto(argumentar, rechazo_argumentar).
opuesto(justicia, desinteres_justicia).
opuesto(liderazgo, rechazo_liderazgo).
opuesto(negocios, desinteres_negocios).
opuesto(organizacion, desorganizacion).
opuesto(creatividad, rechazo_creatividad).
opuesto(arte, desinteres_arte).
opuesto(dibujo, rechazo_dibujo).
opuesto(diseno, rechazo_diseno).
opuesto(ensenar, rechazo_ensenar).
opuesto(paciencia, poca_paciencia).
opuesto(numeros, rechazo_numeros).
opuesto(orden, desorden).
opuesto(finanzas, desinteres_finanzas).
opuesto(hablar, rechazo_hablar).
opuesto(escribir, rechazo_escribir).
opuesto(socializacion, poca_socializacion).
