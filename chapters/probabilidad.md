# Teoría de la Probabilidad

El objetivo de la Probabilidad es modelar y trabajar con incertidumbre. Dicha incertidumbre puede provenir de diversas fuentes, entre ellas:

* Estocasticidad del sistema modelado (e.g. mecánica cuántica, escenarios hipotéticos con aleatoriedad, etc.).
* Falta de observabilidad: los sistemas deterministas se muestran aparentemente estocásticos cuando no se pueden observar todas las variables que los afectan.
* Modelización incompleta: el uso de un modelo que descarta parte de la información observada (un modelo simple pero incompleto puede ser más útil que uno absolutamente preciso).

La probabilidad se puede estudiar desde el enfoque frecuentista, donde se trabaja con las tasas de ocurrencia de sucesos, o desde el enfoque bayesiano, que trata de medir los grados de creencia, de certidumbre, con los que ocurre un evento.

En la práctica se puede partir del mismo tipo de razonamientos y cálculos para trabajar con ambos tipos de probabilidad.

\define
Una **variable aleatoria** es una función medible $X:\Omega\rightarrow E$ donde $\Omega$ es un espacio de probabilidad y $E$ un espacio medible.
\enifed
\define
El par $(E, \Sigma)$ donde $E$ es un conjunto y $\Sigma$ una $\sigma$-álgebra sobre $E$ es un **espacio medible**.
\enifed
\define
Si $(\Omega, \mathcal{F})$ es un espacio medible y $\mu$ es una medida sobre $\mathcal{F}$, entonces la terna $(\Omega, \mathcal{F}, \mu)$ es un **espacio de medida**. Si además se verifica $\mu(\Omega)=1$, entonces se trata de un **espacio de probabilidad**.
\enifed

Intuitivamente, una variable aleatoria representa una variable del problema que puede tomar distintos valores, y la probabilidad con la que se darán dichos valores puede ser descrita por una distribución de probabilidad. Cuando notamos $X:\Omega\rightarrow E$, interpretamos que $\Omega$ es el conjunto de todos los sucesos posibles, y los estados que puede tomar la variable $X$ vienen dados por su imagen, $X(\Omega)\subset E$. Se dice que $X$ es **discreta** si $X(\Omega)$ es numerable (incluyendo el caso finito), y es **continua** si $X(\Omega)$ es no numerable.

Una distribución de probabilidad sobre una variable discreta $X$ se puede describir mediante una función de probabilidad (*Probability Mass Function*, PMF) $P:X(\Omega)\rightarrow [0,1]$, que verifica $\sum_{x\in X(\Omega)} P(x)=1$.

\exampleb
Supongamos que disponemos de una bolsa opaca que contiene 5 bolas. Dos de ellas son negras, el resto azules. Nos situamos en el experimento de sacar una bola de la bolsa y observar su color. En esta situación, una representación coherente de los datos sería
\begin{align*}
\Omega=\{B_1, B_2, B_3, B_4, B_5\},&\quad E=\{\text{negro}, \text{azul}\}\\
X(B_1)=X(B_2)=\text{negro},&\quad X(B_3)=X(B_4)=X(B_5)=\text{azul}
\end{align*}

Ahora, si suponemos que los sucesos dados por la extracción de cada bola son equiprobables, definiremos:
$$P(X=\text{negro})=\frac 2 5,\quad P(X=\text{azul})=\frac 3 5~.$$
\examplee

Una distribución de probabilidad sobre una variable continua $X$ se puede describir mediante una función de densidad (*Probability Density Function*, PDF) $f:X(\Omega)\rightarrow [0,1]$, que verifica $\int_{X(\Omega)} x dx=1$.
