La Teoría de la Información estudia y cuantifica la información presente en una señal. El objetivo de la misma es el diseño de códigos para compresión de datos y la maximización de la tasa de transmisión en comunicación. A causa de sus fundamentos y aplicaciones, es un campo de estudio que se relaciona con muchos otros ámbitos, como la ingeniería eléctrica, la estadística, la probabilidad, la física, la economía y la informática.

A partir de lo estudiado en el capítulo anterior, si queremos añadir una intuición acerca de la información que aporta un suceso, será razonable que la cantidad de información sea menor cuanto más probable sea el suceso dado. En el caso extremo, el suceso seguro no aporta información ninguna.

Para formalizar estas intuiciones, definiremos y haremos uso de conceptos como la entropía. La fuente principal de este capítulo es @coverit.

# Entropía. Propiedades y magnitudes

## Concepto

\defineb
La *entropía* $H$ de una variable aleatoria discreta $X$ con distribución $p(x)=P(X=x)$ viene dada por la siguiente expresión:
$$H(X)=-\sum_{x\in X^{-1}(\Omega)}p(x)\log p(x)~.$$
Si se usa otra base $b$ para el logaritmo de la definición notaremos $H_{b}$.
\definee

Observamos que se puede expresar como la esperanza de una función de la variable $X$:
$$H(X)=\E\left[\frac 1 {\log p(X)}\right]~.$$

Además, es interesante notar que $H$ es un funcional de $p$ en el sentido de que no depende de los valores que tome la variable aleatoria, sino únicamente de la probabilidad de los mismos. El significado que aporta la entropía de una variable es la cantidad de información esperada en un suceso. Por esto, las distribuciones cercanas a la uniforme tienen mayor entropía que las que son casi determinísticas.

## Propiedades

\lemmab
La entropía de una variable es siempre positiva o nula. 
\proofb
Efectivamente, puesto que $0\leq p(x)\leq 1$ para todo $x$, se tiene que $log(1/p(x))\geq 0$, y como consecuencia la esperanza de dicha función de $X$ es no negativa.
\proofe
\lemmae

\lemmab
$H_b(X)=\left(\log_b a\right)H_a(X)$
\label{lm:entropy-base-change}
\proofb
Basta recordar que $\log_{b}p=\log_{b}a\log_a p$ y aplicar la definición.
\proofe
\lemmae

## Magnitudes

Según la base que se tome para los logaritmos, la escala de la entropía varía, por lo que se está midiendo en una magnitud distinta.

* Si se toman logaritmos en base 2, entonces se habla de la entropía en *bits*.
* Si se toman en base $e$, se está midiendo la entropía en *nats*.

Además, el cambio de base del \hyperref[lm:entropy-base-change]{lema \ref*{lm:entropy-base-change}} nos permite convertir de una magnitud a otra:
$$H=(\log 2) H_2~.$$

# Entropía conjunta y entropía condicional

\defineb
La *entropía conjunta* $H(X,Y)$ de dos variables aleatorias discretas con distribución conjunta $p(x,y)$ se define como\begin{equation}H(X,Y)=-\sum_{x\in\Omega}\sum_{x\in\Omega'}p(x,y)\log p(x,y)~,\end{equation} que también se puede expresar como \begin{equation}H(X,Y)=-\E\left[\log p(x,y)\right]~.\end{equation}
\definee

\defineb
Si $(X,Y)\sim p(x,y)$, entonces se define la entropía condicional $H(Y\mid X)$ como
\begin{align}
  H(Y\mid X) &= \sum_{x\in\Omega}p(x)H(Y\mid X=x)\\
             &= -\sum_{x\in\Omega}p(x)\sum_{y\in\Omega'}p(y\mid x) \log p(y \mid x)\\
             &= -\sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y) \log p(y \mid x)\\
             &= -\E_{p(x,y)} \log p(Y \mid X)~.
\end{align}
\definee

Estas dos definiciones están relacionadas por el siguiente teorema.

\theob[Regla de la cadena de la entropía]
$$H(X,Y)=H(X)+H(Y\mid X)$$

\proofb
\begin{align*}
  H(X,Y)&=-\sum_{x\in\Omega}\sum_{x\in\Omega'}p(x,y)\log p(x,y)\\
        &=-\sum_{x\in\Omega}\sum_{x\in\Omega'}p(x,y)\log\left(p(x)p(y\mid x)\right)\\
        &=-\sum_{x\in\Omega}\sum_{x\in\Omega'}p(x,y)\log p(x) - \sum_{x\in\Omega}\sum_{x\in\Omega'}p(x,y)\log p(y\mid x)\\
        &=-\sum_{x\in\Omega}p(x)\log p(x) - \sum_{x\in\Omega}\sum_{x\in\Omega'}p(x,y)\log p(y\mid x)\\
        &=H(X)+H(Y\mid X)~.
\end{align*}

\proofe
\theoe

\corb
$$H(X,Y\mid Z)=H(X\mid Z)+H(Y\mid X,Z)$$
\proofb
La prueba sigue pasos análogos al teorema anterior.
\proofe
\core

# Entropía relativa, información mutua y entropía cruzada

Si la entropía de una variable es una medida de la cantidad de información requerida para explicarla, la entropía relativa de una función de distribución a otra $D(p\Vert q)$ mide la ineficiencia de asumir que la distribución de una variable es $q$ cuando la distribución verdadera es $p$, es decir, la longitud adicional de código basado en $q$ necesaria para describir la variable respecto de un código basado en $p$.

\defineb
La *entropía relativa* o *divergencia de Kullback-Leibler* entre dos funciones de probabilidad $p$ y $q$ se define como $$D(p\Mid q)=\sum_{x\in\Omega}p(x)\log\frac{p(x)}{q(x)}=\E_{p}\left[\log\frac{p(X)}{q(X)}\right]~.$$
\definee

En la definición anterior usamos la convención de que $0\log\frac 0 q=0$ y $p\log\frac p 0=\infty$, basada en argumentos de continuidad.

La entropía relativa adolece de algunas propiedades para ser considerada una distancia entre distribuciones de probabilidad. En concreto, no es simétrica y no satisface la desigualdad triangular.

\defineb
Sean $X, Y$ dos variables aleatorias con función de probabilidad conjunta $p(x,y)$ y funciones de probabilidad marginal $p(x)$ y $p(y)$ respectivamente. La *información mutua* $I(X;Y)$ es la entropía relativa entre la distribución conjunta y el producto de las distribuciones:
\begin{align*}
  I(X;Y)&=\sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y)\log\frac{p(x,y)}{p(x)p(y)}\\
        &=D(p(x,y)\Mid p(x)p(y))\\
        &=\E_{p(x,y)}\left[\log\frac{p(X,Y)}{p(X)p(Y)}\right]~.
\end{align*}
\definee

\theob
La información mutua es la reducción en la incertidumbre de $X$ dado el conocimiento de $Y$. Por simetría además $X$ da tanta información sobre $Y$ como $Y$ sobre $X$:
$$I(X;Y)=H(X)-H(X\mid Y)=H(Y)-H(Y\mid X)~.$$
Además, como consecuencia:
$$I(X;Y)=H(X)+H(Y)-H(X,Y)~,$$
en particular,
$$I(X;X)=H(X)~.$$
\proofb
\begin{align*}
  I(X;Y)&=\sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y)\log\frac{p(x,y)}{p(x)p(y)}\\
        &=\sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y)\log\frac{p(x\mid y)}{p(x)}\\
        &=-\sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y)\log p(x) + \sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y)\log p(x\mid y)\\
        &=-\sum_{x\in\Omega}p(x)\log p(x) -\left(- \sum_{x\in\Omega}\sum_{y\in\Omega'}p(x,y)\log p(x\mid y)\right)\\
        &=H(X)-H(X\mid Y)~.
\end{align*}

Utilizando que $H(X,Y)=H(X)+H(Y\mid X)$ se tiene la consecuencia.
\proofe

\theoe

Definimos una versión condicionada de la entropía relativa.

\defineb
La *entropía relativa condicional* $D\left(p(y\mid x)\Mid q(y\mid x)\right)$ se define como
\begin{gather*}D\left(p(y\mid x)\Mid q(y\mid x)\right)=\\\sum_{x\in\Omega}p(x)\sum_{y\in\Omega'}p(y\mid x)\log\frac{p(y\mid x)}{q(y\mid x)}=\E_{p(x,y)}\left[\log\frac{p(Y\mid X)}{q(Y\mid X)}\right]
\end{gather*}
\definee

Un concepto similar al de entropía relativa es la entropía cruzada. Simplemente, en lugar de considerar la longitud de código adicional al utilizar un código, se considera la longitud completa.

\defineb
La *entropía cruzada* entre dos funciones de probabilidad $p$ y $q$ se define como
$$C(p, q)=H(X) + D(p\mid q)=\E_p\left[\log q(X)\right]~.$$

**Nota:** En ocasiones se utiliza la notación $H(p,q)$ para hablar de entropía cruzada, pudiendo confundirse con la entropía conjunta. En este texto se utilizará en su lugar $C(p,q)$.
\definee

\remb
Podemos tomar la entropía cruzada sobre una variable condicionada a otra de forma natural. Consideremos $X,Y$ variables aleatorias siguiendo una distribución $p$, sobre las que asumimos una distribución $q$. La entropía cruzada de $p$ respecto de $q$ para $Y$ condicionada a $X$ será:
\begin{align*}
  C(p(y\mid x),q(y \mid x))=&H(Y\mid X) + D\left(p(y\mid x)\Mid q(y\mid x)\right)\\
                =&\sum_{x\in\Omega}p(x)\sum_{y\in\Omega'}p(y\mid x)\left(-\log p(y\mid x)
                  +\log\frac{p(y\mid x)}{q(y\mid x)}\right)\\
                =&-\sum_{x\in\Omega}p(x)\sum_{y\in\Omega'}p(y\mid x)\log q(y\mid x)\\
                =&-\E_p[\log q(Y\mid X)]~.
\end{align*}
\reme

# La desigualdad de la información

Vamos a estudiar una de las desigualdades esenciales en Teoría de la Información, que nos dirá que la distribución que determina los códigos más cortos para unos datos es la propia distribución de los datos. Para ello, nos basaremos en una de las desigualdades más usadas en matemáticas, la desigualdad de Jensen.

\theob[Desigualdad de Jensen]
Si $f$ es una función convexa y $X$ es una variable aleatoria, entonces $$\E[f(X)]\geq f(\E[X])~.$$

\proofb
A continuación se expone una demostración para distribuciones discretas con un número finito de puntos de masa, es decir, puntos donde la probabilidad no es nula. Llamamos $x_1, \dots, x_k$ a dichos puntos y $p_1, \dots, p_k$ a las respectivas probabilidades.

Procedemos por inducción en el número de puntos de masa. Para dos puntos de masa, la desigualdad se expresa
$$p_1f(x_1)+p_2f(x_2)\geq f(p_1x_1+p_2x_2)~,$$
que se deduce de la definición de función convexa.

Supuesto el teorema cierto para distribuciones de $k-1$ puntos de masa, veámoslo para $k$ puntos. Escribiendo $p'_{i}=\frac{p_{i}}{1-p_k}$ para $i=1,\dots,k-1$, se tiene
\begin{align*}
  \sum_{i=1}^kp_if(x_i)&=p_kf(x_k)+(1-p_k)\sum_{i=1}^{k-1}p'_if(x_i)\\
                       &\geq p_kf(x_k)+(1-p_k)f\left(\sum_{i=1}^{k-1}p'_ix_i\right)\\
                       &\geq f\left(p_kx_k+(1-p_k) \sum_{i=1}^{k-1}p'_ix_i\right)\\
                       &=f\left(\sum_{i=1}^kP_ix_i\right)~,  
\end{align*}
donde la primera desigualdad se deduce de la hipótesis de inducción y la segunda es consecuencia de la convexidad.

Por argumentos de continuidad se puede extender esta demostración a distribuciones continuas.
\proofe
\theoe

\theob[Desigualdad de la información]
Sean $p$, $q$, funciones de probabilidad de una variable aleatoria $X$. Entonces,
$$D(p\Mid q)\geq 0$$
\proofb
Sea $A=\{x\in\Omega :p(x)>0\}$ el soporte de $p$. Entonces, notando que la función $-\log$ es convexa por concavidad del logaritmo,
\begin{align*}
  D(p\Mid q)&=\E_p\left[-\log\frac{q(X)}{p(X)}\right]\geq -\log\E_p\left[\frac{q(X)}{p(X)}\right]\\
            &=-\log\left(\sum_{x\in\Omega}p(x)\frac{q(x)}{p(x)}\right)=-\log\left(\sum_{x\in\Omega}q(x)\right)\\
            &=-\log 1= 0
\end{align*}
\proofe
\theoe

Las siguientes son algunas consecuencias directas de este resultado.

\corb[No negatividad de la información mutua]
Para cualesquiera dos variables aleatorias $X, Y$ se tiene $I(X;Y)\geq 0$.
\proofb
Por definición de información mutua.
\proofe
\core

\corb
Para cualesquiera dos variables aleatorias $X, Y$ y funciones de probabilidad $p$ y $q$, $$D(p(y\mid x)\Mid q(y\mid x))\geq 0~.$$
\core

\corb
Para una variable aleatoria $X$ y funciones de probabilidad $p$ (dada por la distribución de X) y $q$, $$C(p, q)\geq H(X)~.$$ De igual forma, si $Y$ es otra variable aleatoria con la misma distribución, se tiene $$C(p(y\mid x), q(y\mid x))\geq H(Y\mid X)~.$$
\core