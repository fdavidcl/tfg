---
---

# Motivación

El objetivo de este trabajo era construir un software para el uso de estructuras de deep learning no supervisado. Para ello, mi intención era conocer muy bien los fundamentos del deep learning, tanto en la parte matemática como los algoritmos y técnicas que se originan en el aprendizaje automático y lo hacen posible. Así, por una parte nos vamos a centrar en las ramas de las matemáticas que intervienen: probabilidad, teoría de la información, tensores. Y por otra estudiaremos de forma teórica las técnicas de deep learning que nos permiten implementar nuestra herramienta.

# Índice

He estructurado esta presentación de la misma forma, hablando primero de las matemáticas involucradas, luego de deep learning y finalmente presentando el software que he desarrollado.

# Convergencia

Empezamos con los resultados relevantes de probabilidad. En el trabajo añado además un recordatorio de conceptos, que termina en estos dos resultados bastante básicos sobre convergencia en probabilidad y casi segura. El lema nos dice que si tenemos una sucesión de variables con varianza finita tendiendo a cero, y esperanzas tendiendo a $x$, las propias variables tienden a la constante $x$. Por otro lado, el teorema de la aplicación continua nos dice que si una función es continua casi seguramente, entonces conserva los límites en probabilidad y casi seguros.

# Maldición

Estos resultados son los que permiten demostrar este teorema. De forma teórica, el teorema asume una sucesión de distribuciones de probabilidad, y de cada una se tienen $n$ muestras. Además para cada una tenemos una función no negativa de la que tomamos el mínimo y el máximo absolutos. Bajo una condición de convergencia sobre la varianza de esa variable referente a las funciones tomadas, tenemos que la probabilidad de que dichos máximo y mínimo estén todo lo cerca que queramos es uno.

La interpretación que haremos de este teorema habla de muestras de datos y dimensiones: si $m$ es el número de dimensiones que tiene el conjunto de datos, y $d$ es la distancia de un punto fijo a cualquier otro de la muestra, entonces conforme aumenta el número de dimensiones, el punto más cercano y el más lejano están a una distancia cada vez más similar. Este resultado motiva por tanto nuestro interés por reducir la dimensionalidad de los conjuntos de datos en aprendizaje automático, ya que algunos de los algoritmos más comunes utilizan distancias entre puntos y se ven muy afectados por este fenómeno.

# Entropía

Pasamos ahora a la parte de teoría de la información. La entropía nos habla de la cantidad de información que tiene una variable aleatoria, y en concreto se puede interpretar como la longitud de código que necesitamos para representar sus valores. Si tenemos una variable aleatoria X discreta, la entropía se define de esta forma, como, una suma de las probabilidades por los logaritmos de las mismas. Nótese que depende de las probabilidades y no de los valores de la variable, luego dos variables idénticamente distribuidas presentarán la misma entropía. 

Definimos también la entropía condicionada, que se ve como la suma en X de sus probabilidades por la entropía de Y fijado el valor de X, o equivalentemente tiene esta expresión como la esperanza respecto de la distribución conjunta.

# Entropía cruzada

El concepto interesante para usarlo posteriormente en el trabajo ha sido la entropía cruzada. Esta surge de la divergencia de Kullback-Leibler o entropía relativa, que se define como vemos, y describe la diferencia en la longitud de código que necesitaríamos para representar los valores de X si asumimos que se distribuyen según q respecto a si usáramos su distribución verdadera, p. Si esta cantidad se la sumamos a la entropía de la variable X, ya tenemos la entropía cruzada.

Además, la entropía cruzada tiene una versión condicionada, que se puede expresas de estas dos formas. Esta entropía cruzada se utiliza en Deep Learning para construir las funciones de coste o funciones objetivo que trataremos de optimizar.

# Desigualdad de la información

Pero otro resultado que también nos interesa de la teoría de la información es la desigualdad de la información. Basándonos en la desigualdad de Jensen podemos probar que la divergencia de Kullback-Leibler es siempre no negativa, y como consecuencia la divergencia condicionada también lo es. Esto nos sirve para decir que siempre que asumimos una distribución sobre unos datos, es decir, un modelo, necesitamos una mayor longitud de código que la óptima para representarlos, o lo que es lo mismo, es más difícil comprimirlos sin perder información.

Estos dos resultados están demostrados en la memoria del trabajo.

# Tensor

Por último en la parte matemática, comentaré el concepto de tensor y cómo se lleva al ámbito del aprendizaje automático. Un tensor se puede definir como un funcional multilineal, que se evalúa en un producto de K-espacios vectoriales y da valores de K.

Podemos hablar de tensores que son covariantes o contravariantes en cada variable. Esto se refiere a si el espacio vectorial donde toma valores esa variable es el espacio original de referencia, en cuyo caso decimos que es covariante, o bien es el dual del espacio de referencia, en cuyo caso estamos hablando de ser contravariante.

# Casos particulares

Para ver que los tensores generalizan múltiples estructuras del álgebra lineal, observamos que un funcional lineal es un tensor 1-covariante, un vector v es un tensor 1-contravariante visto en el doble dual, y una constante del cuerpo K es un tensor de tipo 0,0 es decir, 0-covariante, 0-contravariante.

# Tensores en aprendizaje

Para aprovechar esta generalización de estructuras de álgebra lineal, en aprendizaje automático y otras áreas aplicadas se utilizan objetos a los que llamamos también tensores y en realidad son simplemente generalizaciones de los vectores y las matrices, sin aprovechar el resto de propiedades algebraicas que tienen. Sin embargo, sí que existen distintas operaciones y descomposiciones de estos tensores que permiten hacer uso eficiente de la memoria. Por esto es que en las bibliotecas más potentes dedicadas a Deep Learning se implementan, a bajo nivel, operaciones con tensores para construir sobre ellas los algoritmos, y sobre estos las estructuras profundas de aprendizaje.

# Clasificación

Con esto paso a la sección sobre aprendizaje automático, y comento uno de los problemas que nos ocupa: el problema de clasificación. Consiste en aprender a asignar una o varias etiquetas a las instancias sin clasificar que nos lleguen, habiendo aprendido anteriormente mediante un conjunto de entrenamiento en el que las instancias estaban clasificadas.

Más formalmente, el objetivo del problema es, dado un espacio de atributos, un conjunto de etiquetas y un conjunto de instancias etiquetadas, encontrar el clasificador que mejor se adapte al problema, según una o varias métricas de evaluación.

Además, según la estructura del conjunto de etiquetas L se pueden dar problemas binarios, multiclase, multietiqueta y multidimensional.

# Reducción de dimensionalidad

El otro problema al que nos enfrentamos es cómo reducir la dimensionalidad de un conjunto de datos, es decir, el número de dimensiones del espacio de atributos, sin perder mucha información. Esto es necesario ya que hemos visto en la parte de probabilidad que al aumentar el número de dimensiones, la distancia dejaba de ser significativa. Hay dos vías para tratar el problema, la construcción de nuevas características para sustituir  a las originales y la selección de características entre la existentes. En nuestro caso, trabajaremos por la primera vía.

# Gradiente descendente

Puesto que al final modelaremos el problema como la búsqueda del mínimo de una función de coste, nos interesa conocer los algoritmos de optimización presentes en el aprendizaje automático. Uno de los clásicos, y en el que se basan los utilizados en deep learning, es gradiente descendente. Sabiendo que el gradiente de una función apunta en la dirección y sentido de mayor pendiente, si buscamos el mínimo basta con ir saltando poco a poco y evaluando de nuevo en cada punto el gradiente de la función, para buscar la nueva dirección de salto. Al paso que damos se le llama tasa de aprendizaje. El origen de este algoritmo se debe a Cauchy, que lo publicó en 1847.

# Grad desc II

Y aquí podemos ver un ejemplo de cómo avanza el algoritmo: cuando encuentra gradientes grandes avanza a mayores pasos, y conforme se acerca al óptimo, en este caso el máximo, da pasos vada vez más cortos. Esto presenta algunas desventajas, podemos ver que avanza en zigzag y que la convergencia al final es muy lenta. Algunas de las variantes de este algoritmo para deep learning lo solucionan.

# Neuronas artificiales

Entro ya en lo que es deep learning, presentando la base de toda red neuronal, la neurona artificial. La similitud con un tipo de neuronas biológicas la vemos aquí: ambas reciben entradas que acumulan, evalúan de alguna forma y esto permite producir un estímulo de salida. La neurona artificial simplemente realiza una suma de las entradas ponderada mediante pesos, y le aplica una función que llamamos de activación.

# Redes profundas

Si acumulamos muchas de estas neuronas o unidades, podemos construir redes profundas, es decir, de varias capas. A cada una de las neuronas de la primera capa les llegan todos los datos de entrada, que los transforman y los pasan a la siguiente, y así sucesivamente. La salida de la red puede tener una o más neuronas según el objetivo que tenga.

Esencialmente, las redes neuronales prealimentadas, es decir, las que no tienen ciclos vistas como grafo, representan una composición de funciones y transformaciones lineales como la que veíamos para una sola neurona. A la derecha vemos un ejemplo de este tipo de redes.

# Unidades y algoritmos

Las unidades de una red pueden ser ocultas o de salida. Las de salida forman la última capa y el resto se denominan generalmente ocultas. Las de salida además determinan la función de coste a optimizar.

Por otro lado, las funciones de activación que pueden tener cada una de estas capas de unidades son diversas: desde ninguna, es decir, simplemente la unidad lineal, pasando por algunas rectificaciones como la ReLU, o funciones como la logística, la tangente hiperbólica, softmax, softplus, etc. que están definidas y explicadas en la memoria.

En el proceso de entrenamiento de una red neuronal, se intenta optimizar los pesos para que la salida de la red sea lo más similar posible a la salida deseada. Aquí se involucran varios algoritmos. Primero, para evaluar la salida de la red ante valores de entrada se usa la propagación hacia adelante. Para calcular los gradientes necesarios, propagación hacia atrás. Y para optimizar todo el conjunto de parámetros, variantes más eficientes de gradiente descendente como gradiente descendente estocástico, AdaGrad, RMSProp o Adam. Todos estos algoritmos vienen descritos en la memoria, por restricciones de tiempo no me detengo más en ellos.

# Estructuras profundas no supervisadas

La estructura profunda no supervisada canónica es el autoencoder, que vemos a la derecha, que puede contar con todas las capas que queramos, siempre se forma simétrica. Lo que aprende el autoencoder es a reconstruir la entrada a la salida, pero de alguna forma se le restringe para que no aprenda simplemente a copiarla. Por ejemplo, en los autoencoders infracompletos como el de la figura, debe construir una codificación de los datos en menos dimensiones para poder reconstruirla. Otros tipos de autoencoder son el disperso, el contractivo y el eliminador de ruido.

Por otro lado tenemos a la máquina de boltzmann restringida, que es un modelo muy distinto, de sólo dos capas y basado en una función de energía. Aprende algo similar al autoencoder, pero se entrena hacia adelante y hacia atrás, tratando de reconstruir la capa visible v mediante la oculta h. En deep learning se utiliza como base para construir otras estructuras o para la fase de entrenamiento, por ejemplo, hay una propuesta de pre-entrenamiento de autoencoders que utiliza RBMs.


# R y MXNet

Paso ya a contar la herramienta que he implementado en este trabajo, se trata de una herramienta para R basada en MXNet así que comento rápidamente lo que son: R es un lenguaje de programación orientado a datos, que tiene una potente plataforma de paquetes con todo tipo de bibliotecas, y viene de serie con estructuras de datos que representan conjuntos de datos como el data.frame.

MXNet, por otro lado, es una biblioteca que implementa en C++ los optimizadores y otros algoritmos necesarios para construir redes neuronales, es más rápida que otras bibliotecas competidoras y permite ser usada desde R.

# Ruta I

He desarrollado dos paquetes para R, complementarios el uno del otro, que permiten usar y estudiar las estructuras no supervisadas de Deep Learning que acabamos de conocer. Un prototipo muy preliminar lo presenté en el congreso CAEPIA 2016 bajo el nombre "dlvisR". Además, ambas herramientas están liberadas bajo la GPL 3 de GNU. 

Estoy usando también un sistema de integración continua para construir y comprobar las builds a cada cambio del código que suba, y he desarrollado un pequeño sitio web que da acceso al paquete y la documentación, que está disponible en la dirección *ruta punto software*.

# Ruta II

La herramienta principal, Ruta, reparte su funcionalidad en tres módulos. El primero es el de tareas. Una tarea de aprendizaje se corresponde con un conjunto de datos y algunos parámetros acerca de dicho conjunto. El usuario las puede generar con la función ruta.makeTask y derivadas como ruta.makeUnsupervisedTask. Aquí vemos un ejemplo

# Ruta III

La parte importante de la implementación son las estructuras de aprendizaje; Ruta permite construir autoencoders y RBMs con un sencillo comando ruta.makeLearner. Una vez construidos se pueden entrenar con train, ajustando los parámetros que deseemos. Vemos en el ejemplo que construimos un autoencoder de 3 capas con codificación de 2 unidades, activación de tipo leaky ReLU. Lo pre-entrenamos con el proceso descrito en el trabajo como pila de RBMs, y lo entrenamos ajustando el optimizador, el número de épocas y la tasa de aprendizaje, entre otros parámetros.

# Ruta IV

Una vez hemos obtenido un modelo entrenado, podemos utilizarlo de diversas formas, bien para obtener las codificaciones para nuevos datos, o extraer la capa de salida de la red que corresponde a las reconstrucciones, o bien cualquier otra capa intermedia, mediante la función ruta.layerOutputs. Esta utiliza por debajo una funcionalidad bastante avanzada que no estaba presente en la biblioteca MXNet y he implementado yo, interactuando directamente sobre la red y propagando los datos en una función propia. En este ejemplo obtendríamos la codificación generada por el autoencoder para la misma tarea con la que se entrenó.

# Rutavis I

La segunda herramienta se denomina Rutavis, y permite realizar visualizaciones sobre los modelos entrenados por un autoencoder. Estos gráficos son interactivos gracias a la biblioteca Plotly, como el ejemplo que vemos a la derecha, realizado sobre el conocido conjunto Iris.

Además, incluye también una interfaz de usuario web, de forma que el usuario puede crear, entrenar y visualizar modelos sin programar nada.

# Rutavis II

Aquí muestro la interfaz gráfica de Rutavis. Cuenta con una barra superior de pestañas y modos de visualización: visualización única, en mosaico o en formato notebook. A la izquierda se muestra el panel de ajustes que permite seleccionar un conjunto de datos, construir y entrenar un modelo y en la parte derecha se visualizará la capa de codificación del autoencoder configurado.

# Rutavis III

En estas capturas de pantalla muestro con más detalle el panel de ajustes, donde en este caso se está usando el dataset de diagnóstico de cáncer en Wisconsin, con un autoencoder con activación Leaky, 3 unidades ocultas y 200 épocas, optimizador adagrad y tasa de aprendizaje 0.02. A la derecha muestro el modo mosaico, en el que se pueden comparar fácilmente dos visualizaciones generadas por rutavis.

# Conclusiones

En este trabajo hemos estudiado las técnicas no supervisadas de deep learning desde sus orígenes matemáticos, hasta una implementación práctica y con muchas facilidades para el usuario. Así, hemos cumplido nuestros objetivos pero esto nos abre distintas vías de trabajo. Entre ellas puedo mencionar el añadir más variantes de autoencoders a Ruta, o más visualizaciones en Rutavis. También se podrían introducir comparaciones con otras técnicas de reducción de la dimensionalidad no basadas en deep learning, como t-SNE y Locally Linear Embedding.

# Fin

Esto es todo por mi parte, muchas gracias por su atención y estoy abierto a cualquier pregunta que tengan.

# Time tracking

* Primer ensayo (leyendo): 17:46
