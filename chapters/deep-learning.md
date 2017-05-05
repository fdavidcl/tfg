# Introducción

## Aprendizaje automático

El aprendizaje profundo o Deep Learning comprende una clase de técnicas englobadas dentro del aprendizaje automático. Esta sección introduce los conceptos básicos de aprendizaje automático, que son comunes a todas lastécnicas desarrolladas en el ámbito.

Un *algoritmo de aprendizaje*, según @mitchell1997 es un programa cuyo rendimiento respecto de un conjunto de tareas $T$ y una medida de rendimiento $P$ mejora tras conocer una experiencia $E$. En ese caso, se dice que el algoritmo ha *aprendido* de dicha experiencia.

Estas tareas y experiencias pueden ser de muy diversas clases, lo que propicia la aparición de algoritmos y técnicas de aprendizaje diferentes que tratan de abordarlas. Estos algoritmos computacionales son necesarios cuando la complejidad o el tamaño de la tarea impide tratarla con técnicas manuales.

Entre las tareas de aprendizaje que se presentan en la literatura se incluyen:

- clasificación
- regresión
- detección de anomalías
- agrupamiento (*clustering*)
- reducción de dimensionalidad
- detección y eliminación de ruido
- traducción automática

Por otro lado, la mayoría de *experiencias* de las que puede aprender un algoritmo permite categorizarlos en dos grandes clases: supervisados y no supervisados.

### Aprendizaje supervisado

En este tipo de aprendizaje, se le proporciona al algoritmo un conjunto de ejemplos para los cuales la tarea está resuelta. Así, se pretende que aprenda a realizar la misma tarea para nuevos ejemplos.

Un caso particular de esta clase de aprendizaje lo forman los problemas de clasificación. En ellos, el programa debe deducir para cada ejemplo una etiqueta o clase, y para ello el aprendizaje se suele realizar mediante un conjunto de ejemplos que ya tienen asignada su etiqueta.

Entre las aplicaciones del aprendizaje supervisado se encuentran la clasificación de mensajes de correo (en particular de spam) [@cohen1996], diagnóstico de enfermedades [@kononenko2001] y detección de fraude [@phua2010].

### Aprendizaje no supervisado

Esta modalidad de aprendizaje implica a tareas de las que el algoritmo no tiene una resolución previa para ejemplos. La experiencia que se le proporciona puede estar basada en otras características de los datos.

Un caso particular es la clase de problemas de agrupamiento o *clustering*, en la cual se proporcionan al algoritmo datos sin clasificar que debe subdividir en diferentes conjuntos de forma que los datos del mismo conjunto sean más similares entre sí que entre elementos de distintos conjuntos.

El aprendizaje no supervisado abarca multitud de problemas ampliamente estudiados que tienen diversas aplicaciones presentes en distintos campos, como el tratamiento de imágenes y reconocimiento de objetos [@ranzato], análisis semántico [@hofmann] y sintáctico del lenguaje [@brent] o el preprocesamiento de datos y pre-entrenamiento para una posterior fase de aprendizaje [@erhan2009].

### Problema de clasificación

Un problema clásico en el aprendizaje automático es el de clasificación. Una formulación sencilla del problema es la siguiente:

\defineb
Sean $A_1, A_2, \dots A_f$ conjuntos no vacíos llamados *atributos de entrada*. Llamaremos *espacio de atributos* (o *espacio de características*) a $\mathcal A=A_1\times A_2\times\dots\times A_f$.
\definee

<!--
\defineb
Dado $L$ un conjunto finito, que llamaremos de *clases* o *etiquetas*, sea $l:\mathcal A\rightarrow L$ una aplicación que denominaremos *verdadero etiquetado*.
\definee
-->

\defineb
Sea $D\subset \mathcal A\times L$ un subconjunto finito del espacio de atributos, lo llamaremos *conjunto de instancias* o *dataset*.
\definee

\defineb
Decimos que la tripleta $\mathcal P=\left(\mathcal A, L, D\right)$ es un *problema de clasificación*.
\definee

\defineb
Dado un problema de clasificación $\left(\mathcal A, L, D\right)$, un *clasificador* es una aplicación $c:\mathcal A\rightarrow L$.
\definee

Así, el objetivo que se persigue al abordar un problema de clasificación $\mathcal P$ es encontrar el clasificador $c$ que mejor se adapte al problema, según una o varias métricas de evaluación. Intuitivamente, el procedimiento por el que se obtenga dicho clasificador debe ser capaz de utilizar la información de las instancias en el dataset $D$ para predecir una clase en nuevas instancias del espacio de atributos.

Las definiciones previas componen una formalización simple del problema de clasificación. Una modelización más detallada y con resultados teóricos interesantes se encuentra en la Teoría de Aprendizaje PAC [@shwartz2014].

### Problema de reducción de dimensionalidad



## Redes neuronales artificiales

## Deep Learning

[@goodfellow2016]

# Estructuras profundas no supervisadas

## Autoencoders

# Referencias
