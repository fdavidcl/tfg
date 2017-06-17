# Recordatorio

El objetivo de la Probabilidad es modelar y trabajar con incertidumbre. Dicha incertidumbre puede provenir de diversas fuentes, entre ellas:

* Estocasticidad del sistema modelado (e.g. mecánica cuántica, escenarios hipotéticos con aleatoriedad, etc.).
* Falta de observabilidad: los sistemas deterministas se muestran aparentemente estocásticos cuando no se pueden observar todas las variables que los afectan.
* Modelización incompleta: el uso de un modelo que descarta parte de la información observada (un modelo simple pero incompleto puede ser más útil que uno absolutamente preciso).

La probabilidad se puede estudiar desde el enfoque frecuentista, donde se trabaja con las tasas de ocurrencia de sucesos, o desde el enfoque bayesiano, que trata de medir los grados de creencia, de certidumbre, con los que ocurre un evento. En la práctica se puede partir del mismo tipo de razonamientos y cálculos para trabajar con ambos tipos de probabilidad.

En esta sección se realiza un recordatorio de conceptos necesarios para trabajar con probabilidades en el resto del texto.

\defineb
Una **variable aleatoria** es una función medible $X:\Omega\rightarrow E$ donde $\Omega$ es un espacio de probabilidad y $E$ un espacio métrico.
\definee
\defineb
El par $(\Omega, \Sigma)$ donde $\Omega$ es un conjunto y $\Sigma$ una $\sigma$-álgebra sobre $\Omega$ es un **espacio medible**.
\definee
\defineb
Si $(\Omega, \mathcal{F})$ es un espacio medible y $\mu$ es una medida sobre $\mathcal{F}$, entonces la terna $(\Omega, \mathcal{F}, \mu)$ es un **espacio de medida**. Si además se verifica $\mu(\Omega)=1$, entonces se trata de un **espacio de probabilidad**.
\definee

Intuitivamente, una variable aleatoria representa una variable del problema que puede tomar distintos valores, y la probabilidad con la que se darán dichos valores puede ser descrita por una distribución de probabilidad. Cuando notamos $X:\Omega\rightarrow E$, interpretamos que $\Omega$ es el conjunto de todos los sucesos posibles, y los estados que puede tomar la variable $X$ vienen dados por su imagen, $X(\Omega)\subset E$. Se dice que $X$ es **discreta** si $X(\Omega)$ es numerable (incluyendo el caso finito), y es **continua** si $X(\Omega)$ es no numerable.

Una distribución de probabilidad sobre una variable discreta $X$ se puede describir mediante una función de probabilidad (*Probability Mass Function*, PMF) $P:X(\Omega)\rightarrow [0,1]$, que verifica $\sum_{x\in X(\Omega)} P(x)=1$.

<!--
\exampleb
Supongamos que disponemos de una bolsa opaca que contiene 5 bolas. Dos de ellas son negras, el resto azules. Nos situamos en el experimento de sacar una bola de la bolsa y observar su color. En esta situación, una representación coherente de los datos sería
\begin{align*}
\Omega=\{B_1, B_2, B_3, B_4, B_5\},&\quad E=\{\text{negro}, \text{azul}\}\\
X(B_1)=X(B_2)=\text{negro},&\quad X(B_3)=X(B_4)=X(B_5)=\text{azul}
\end{align*}

Ahora, si suponemos que los sucesos dados por la extracción de cada bola son equiprobables, definiremos:
$$P(X=\text{negro})=\frac 2 5,\quad P(X=\text{azul})=\frac 3 5~.$$
\examplee
-->

Una distribución de probabilidad sobre una variable continua $X$ se puede describir mediante una función de densidad (*Probability Density Function*, PDF) $p:X(\Omega)\rightarrow [0,1]$, que verifica $\int_{X(\Omega)} x dx=1$.

Cuando una distribución describe varias variables, puede interesar conocer la distribución de un subconjunto de las mismas. Esta se denomina **distribución marginal**, y se consigue sumando o integrando a lo largo de todos los valores de las variables que no están en el subconjunto. Por ejemplo, si $X$ e $Y$ son variables discretas, se tiene $$P(x) = \sum_{y\in Y(\Omega)}P(x, y)~.$$ Si son continuas, entonces se verifica $$P(x) = \int\limits_{Y(\Omega)}p(x, y)dy~.$$

## Probabilidad condicionada

En ocasiones es útil representar la probabilidad de un suceso condicionado a la ocurrencia de otro. Para ello se utilizan **probabilidades condicionadas**, que se notan $P(y|x)$ (donde $y\in Y(\Omega), x\in X(\Omega)$) y se calculan mediante la siguiente fórmula, suponiendo que $P(x) > 0$:
\begin{equation}P(y|x)=\frac{P(y,x)}{P(x)}~.\label{eq:cond}\end{equation}

### Encadenando probabilidades condicionadas

Una distribución de probabilidad conjunta sobre varias variables se puede descomponer como probabilidades condicionadas sobre una sola variable:
$$P(x_1, \dots x_n) = P(x_1)\prod\limits_{i=2}^n P(x_i\mid x_1, \dots x_{i-1})~.$$

Esta expresión se deduce por inducción de la ecuación \ref{eq:cond}.

## Independencia e independencia condicionada

Dos variables aleatorias, $X$ e $Y$, son **independientes** si la su probabilidad conjunta equivale al producto de sus probabilidades:
$$P(x,y)=P(x)P(y)\forall x\in X^{-1}(\Omega),y\in Y^{-1}(\Omega)~.$$

Además, se dice que son **condicionalmente independientes** respecto a una variable $Z$ si la distribución de probabilidad condicionada se factoriza por $X$ e $Y$:
$$P(x,y|z)=P(x|z)P(y|z)\forall x\in X^{-1}(\Omega),y\in Y^{-1}(\Omega),z\in Z^{-1}(\Omega)~.$$

## Momentos: esperanza, varianza y covarianza

La **esperanza** de una variable aleatoria $X$ viene dada por las expresiones siguientes, para variables discretas y continuas respectivamente:
$$\mathrm E[X]=\sum_{x\in X^{-1}(\Omega)}xP(x);\quad \mathrm E[X]=\int_{X^{-1}(\Omega)}xp(x)dx~.$$

**Nota**: Todos los momentos se toman respecto de una variable aleatoria y una distribución de probabilidad asociada, por lo que la notación correcta sería $\mathrm E_{X~P}[X]$. Sin embargo, se omitirá excepto para prevenir ambigüedades.

Se puede definir la esperanza de una función $f$ sobre los valores de una variable aleatoria, del siguiente modo:
$$\mathrm E[X]=\sum_{x\in X^{-1}(\Omega)}f(x)P(x);\quad \mathrm E[X]=\int_{X^{-1}(\Omega)}f(x)p(x)dx~.$$

La **varianza** da idea acerca de cómo de diferentes entre sí son los valores de una variables conforme se muestrean por su distribución de probabilidad:
$$\mathrm{Var}(X)=\mathrm E[(X-\mathrm E[X])^2]~.$$

La **covarianza** relaciona dos variables aleatorias, indicando la medida en que están relacionadas linealmente y la escala de dichas variables:
$$\mathrm{Cov}(X, Y)=\mathrm E[(X-\mathrm E[X])(Y-\mathrm E[Y])]~.$$

Para un vector de variables aleatorias, $X=(X_1, \dots X_n)$, la **matriz de covarianza** se define como una función matriz $n\times n$ dada por:
$$\mathrm{Cov}(X)_{i,j}=\mathrm{Cov}(X_i, X_j)~.$$

# Resultados de convergencia

Sea $d$ una distancia en $\RR^k$ y sea $\{X_n:\Omega\rightarrow\RR^k\}$ una sucesión de variables aleatorias, sea $X:\Omega \rightarrow \RR^k$ una variable aleatoria.

\defineb
Se dice que $X_n$  *converge en probabilidad* a $X$ si para cada $\varepsilon>0$ se tiene $P(d(X_n, X)>\varepsilon)\rightarrow 0$. Lo denotamos $X_n\pconv X$. 
\definee

\defineb
Se dice que $X_n$ *converge casi seguramente* a $X$ si se da la convergencia puntual en un conjunto de medida 1:
$$X_n\asconv X\Leftrightarrow P\left(\lim_{n\rightarrow +\infty} d(X_n, X)=0\right)=1$$
\definee

Es un resultado conocido que $X_n\pconv X\Rightarrow X_n\asconv X$.

\lemmab
\label{lm:convergencia-va}
Si $\{X_n\}$ es una sucesión de variables aleatorias con varianza finita y se verifican las siguientes condiciones:
$$\exists x\in \mathbb R:\lim_{m\rightarrow +\infty} \mathrm{E}[X_m]=x,\quad \lim_{m\rightarrow +\infty} \mathrm{Var}[X_m]=0,$$
entonces se tiene que $X_m\pconv x$.
\lemmae

\theob[Teorema de la aplicación continua]
\label{th:cont-map-conv}
Sea $\{X_n\}$ es una sucesión de variables aleatorias y $X$ una variable aleatoria, valuadas en un espacio medible $E$. Sea $g:E\rightarrow F$ con $F$ otro espacio medible. Entonces, si $g$ es continua casi por doquier, se tiene:
\begin{gather*}
  X_n\pconv X \Rightarrow g(X_n)\pconv g(X),\\
  X_n\asconv X \Rightarrow g(X_n)\asconv g(X).
\end{gather*}
\theoe

# ~Herramientas de inferencia estadística (?)~

## Estimadores máximo-verosímiles
