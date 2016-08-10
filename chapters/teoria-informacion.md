# Teoría de la Información

La Teoría de la Información estudia y cuantifica la información presente en una señal. El objetivo de la misma es el diseño de códigos para compresión de datos y la maximización de la tasa de transmisión en comunicación. A causa de sus fundamentos y aplicaciones, es un campo de estudio que se relaciona con muchos otros ámbitos, como la ingeniería eléctrica, la estadística, la probabilidad, la física, la economía y la informática.

A partir de lo estudiado en el capítulo anterior, si queremos añadir una intuición acerca de la información que aporta un suceso, será razonable que la cantidad de información sea menor cuanto más probable sea el suceso dado. En el caso extremo, el suceso seguro no aporta información ninguna.

Para formalizar estas intuiciones, definiremos y haremos uso de conceptos como la entropía.

## Entropía

La **entropía** $H$ de una variable aleatoria discreta $X$ viene dada por la siguiente expresión:
$$H(X)=-\sum_{x\in X^{-1}(\Omega)}P(x)\log P(x)~.$$

Observamos que se puede expresar como la esperanza de una función de la variable $X$:
$$H(X)=\mathrm E\left[\frac 1 {\log P(X)}\right]~.$$

Además, es interesante notar que $H$ es un funcional de $P$ en el sentido de que no depende de los valores que tome la variable aleatoria, sino únicamente de la probabilidad de los mismos.

### Magnitudes

Según la base que se tome para los logaritmos, la escala de la entropía varía, por lo que se está midiendo en una magnitud distinta.

* Si se toman logaritmos en base 2, entonces se habla de la entropía en **bits**.
* Si se toman en base $e$, se está midiendo la entropía en **nats**.

Además, el cambio de base de los logaritmos nos permite convertir de una magnitud a otra:
$$H_e=(\log 2) H_2~,$$
donde $\log$ denota el logaritmo neperiano.

### Propiedades

Podemos afirmar que la entropía de una variable es siempre positiva o nula. Efectivamente, puesto que $0\leq P(x)\leq 1$ para todo $x$, se tiene que $log(1/p(x))\geq 0$, y como consecuencia la esperanza de dicha función de $X$ es no negativa.

## Referencias

* **Cover, Thomas. Elements of Information Theory**
* Goodfellow, Bengio. Deep Learning Book
* Cesa-Bianchi. Apuntes de *Teoria dell'Informazione e della Trasmissione*
