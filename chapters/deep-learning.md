# Redes neuronales prealimentadas profundas

Las redes prealimentadas profundas, también conocidas como perceptrones multicapa, son el modelo canónico de aprendizaje profundo [@goodfellow2016]. El objetivo de una red prealimentada es aproximar una función $f^{*}$, definiendo una aplicación $f(x;\theta)$ y aprendiendo el valor de los parámetros $\theta$ que resultan en la mejor aproximación.

En concreto, las redes prealimentadas se caracterizan por que no se forman ciclos en las conexiones entre unidades. Así, la información se evalúa siempre hacia adelante a través de las conexiones intermedias usadas para definir $f$, hasta la salida de la red. No hay retroalimentaciones en las que salidas de algunas unidades de la red vuelvan a ser entradas del modelo.

Estas redes se suelen representar como una composición en cadena de varias funciones, que se puede asociar a un grafo acíclico. Por ejemplo, podríamos tener una red composición de funciones vectoriales $f_1, f_2, f_3$ de la siguiente forma: $f(x)=f_3(f_2(f_1(x)))$. En este caso, decimos que $f_1$ es la primera capa, $f_2$ la segunda capa y $f_3$ la capa de salida. Las capas que no corresponden a la salida de $f$ se suelen denominar *capas ocultas*. La longitud de esta cadena nos da la profundidad del modelo.

A diferencia de otros algoritmos de aprendizaje automático, las redes neuronales mantienen esta estructura de capas de forma que la capa $i+1$-ésima únicamente opera con los datos de salida de la $i$-ésima; en particular, sólo la primera capa utiliza directamente los datos de entrada. Además, por la inspiración biológica de las redes, cada componente de cada capa se puede interpretar como una *neurona*, actuando como una función de $\RR^{n_{i-1}}$ en $\RR$, donde $n_{i-1}$ es el número de componentes de la capa anterior. El comportamiento es similar a una neurona en el sentido de que recoge información de varias unidades cercanas y calcula su propio valor de activación, así como la estructuración en capas se ha tomado de la neurociencia.
 
# Optimización en Deep Learning

## Gradiente descendiente estocástico (SGD)

En aprendizaje automático, es común utilizar conjuntos de datos con un gran número de instancias, para favorecer la capacidad de generalización de los modelos producidos por algoritmos. Esto provoca que el coste computacional de calcular cada paso de un gradiente descendente haga inviable su uso. Sin embargo, se puede utilizar una aproximación estocástica al algoritmo denominada gradiente descendiente estocástico (*Stochastic Gradient Descent*, SGD). En esta versión de gradiente descendiente se asienta la mayor parte del desarrollo del Deep Learning en la actualidad.

Al ser una aproximación estocástica, SGD calcula un estimador del gradiente de la función objetivo a partir de un número reducido de muestras.

\begin{algorithm}
\caption{Gradiente descendiente estocástico, iteración $k$-ésima}
\label{alg:sgd}
\begin{algorithmic}
  \REQUIRE{Tasa de aprendizaje $\varepsilon_k$}
  \REQUIRE{Parámetro inicial $\theta$}
  \WHILE{no se alcanza criterio de parada}
  \STATE{Escoger un minilote de $m$ instancias del conjunto de entrenamiento $x^{(1)},\dots,x^{(m)}$ con correspondientes objetivos $y^{(i)}$}
  \STATE{Calcular estimador del gradiente: $\hat g\gets \frac 1 m \nabla \sum_i L(f(x^{(i)}; \theta),y^{(i)})$}
  \STATE{Actualizar parámetro: $\theta\gets\theta - \varepsilon_k\hat g$}
  \ENDWHILE
\end{algorithmic}
\end{algorithm}

## Variantes de SGD

### SGD con momento

\begin{algorithm}
\caption{Gradiente descendiente estocástico con momento}
\label{alg:sgdm}
\begin{algorithmic}
  \REQUIRE{Tasa de aprendizaje $\varepsilon$, momento $\alpha$}
  \REQUIRE{Parámetro inicial $\theta$, velocidad inicial $v$}
  \WHILE{no se alcanza criterio de parada}
  \STATE{Escoger un minilote de $m$ instancias del conjunto de entrenamiento $x^{(1)},\dots,x^{(m)}$ con correspondientes objetivos $y^{(i)}$}
  \STATE{Calcular estimador del gradiente: $\hat g\gets \frac 1 m \nabla \sum_i L(f(x^{(i)}; \theta),y^{(i)})$}
  \STATE{Actualizar la velocidad: $v\gets\alpha v - \varepsilon \hat g$}
  \STATE{Actualizar parámetro: $\theta\gets\theta + v$}
  \ENDWHILE
\end{algorithmic}
\end{algorithm}

### AdaGrad

@adagrad

\begin{algorithm}
\caption{Adagrad}
\label{alg:adagrad}
\begin{algorithmic}
  \REQUIRE{Tasa de aprendizaje $\varepsilon$, constante pequeña $\delta$}
  \REQUIRE{Parámetro inicial $\theta$}
  \STATE{Inicializar: $r\gets 0$}
  \WHILE{no se alcanza criterio de parada}
  \STATE{Escoger un minilote de $m$ instancias del conjunto de entrenamiento $x^{(1)},\dots,x^{(m)}$ con correspondientes objetivos $y^{(i)}$}
  \STATE{Calcular estimador del gradiente: $\hat g\gets \frac 1 m \nabla \sum_i L(f(x^{(i)}; \theta),y^{(i)})$}
  \STATE{Acumular cuadrado del gradiente: $r\gets r + \hat g\odot \hat g$}
  \STATE{Calcular actualización: $\Delta\theta\gets - \frac{\varepsilon}{\delta + \sqrt{r}}\odot \hat g$}
  \STATE{Actualizar parámetro: $\theta\gets\theta + \Delta\theta$}
  \ENDWHILE
\end{algorithmic}
\end{algorithm}

donde $\odot$ es el producto componente a componente, $\sqrt{.}$ es la raíz cuadrada componente a componente y la división por $\frac{1}{\delta + \sqrt r}$ se realiza componente a componente.

### RMSProp

\begin{algorithm}
\caption{RMSProp}
\label{alg:rmsprop}
\begin{algorithmic}
  \REQUIRE{Tasa de aprendizaje $\varepsilon$, constante pequeña $\delta$}
  \REQUIRE{Tasa de decaimiento $\rho$}
  \REQUIRE{Parámetro inicial $\theta$}
  \STATE{Inicializar: $r\gets 0$}
  \WHILE{no se alcanza criterio de parada}
  \STATE{Escoger un minilote de $m$ instancias del conjunto de entrenamiento $x^{(1)},\dots,x^{(m)}$ con correspondientes objetivos $y^{(i)}$}
  \STATE{Calcular estimador del gradiente: $\hat g\gets \frac 1 m \nabla \sum_i L(f(x^{(i)}; \theta),y^{(i)})$}
  \STATE{Acumular cuadrado del gradiente: $r\gets \rho r + (1 - \rho) \hat g\odot \hat g$}
  \STATE{Calcular actualización: $\Delta\theta\gets - \frac{\varepsilon}{\sqrt{\delta + r}}\odot \hat g$}
  \STATE{Actualizar parámetro: $\theta\gets\theta + \Delta\theta$}
  \ENDWHILE
\end{algorithmic}
\end{algorithm}

De nuevo, las operaciones $\odot$, raíz cuadrada y división se realizan componente a componente.

### Adam

\begin{algorithm}
\caption{Adam}
\label{alg:adam}
\begin{algorithmic}
  \REQUIRE{Tasa de aprendizaje $\varepsilon$, constante pequeña $\delta$}
  \REQUIRE{Tasas de decaimiento exponencial $\rho_{1}, \rho_2\in[0,1[$}
  \REQUIRE{Parámetro inicial $\theta$}
  \STATE{Inicializar: $s\gets 0, r\gets 0, t\gets 0$}
  \WHILE{no se alcanza criterio de parada}
  \STATE{Escoger un minilote de $m$ instancias del conjunto de entrenamiento $x^{(1)},\dots,x^{(m)}$ con correspondientes objetivos $y^{(i)}$}
  \STATE{Calcular estimador del gradiente: $\hat g\gets \frac 1 m \nabla \sum_i L(f(x^{(i)}; \theta),y^{(i)})$}
  \STATE{Incrementar tiempo: $t\gets t + 1$}
  \STATE{Actualizar estimador sesgado del 1er momento: $s\gets \rho_1 s + (1 - \rho_1)\hat g$}
  \STATE{Actualizar estimador sesgado del 2º momento: $r\gets \rho_2 s + (1 - \rho_2)\hat g\odot \hat g$}
  \STATE{Corregir sesgos: $\hat s\gets\frac{s}{1 - \rho_1^t},\ \hat r\gets\frac{r}{1 - \rho_2^t}$}
  \STATE{Calcular actualización: $\Delta\theta\gets - \frac{\varepsilon}{\delta + \sqrt{\hat r}}\hat s$ (operaciones componente a componente)}
  \STATE{Actualizar parámetro: $\theta\gets\theta + \Delta\theta$}
  \ENDWHILE
\end{algorithmic}
\end{algorithm}

# Estructuras profundas no supervisadas

## Máquina de Boltzmann restringidas (RBM)

## Autoencoder

@hinton2006autoencoder

## Entrenamiento de autoencoders

### Pre-entrenamiento

### Ajuste fino

# Referencias
