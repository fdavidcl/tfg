# Álgebra Tensorial

## Espacios duales

### Funcionales lineales y el espacio dual

\defineb
Un **funcional lineal** en un espacio vectorial finito dimensional $V$ sobre un cuerpo $K$ es una aplicación lineal $L:V\rightarrow K$.
\definee
\defineb
El **espacio dual** de un espacio vectorial finito dimensional $V$ es $V^*=\{L:V\rightarrow K\text{ lineal}\}=\mathcal{L}(V, K)$.
\definee

\exampleb
Sea $V=\mathbb R^n$ y consideramos $(\mathbb R^n)^*=\left\{L:\mathbb R^n\rightarrow\mathbb R\text{ lineal}\right\}$. Sabemos que toda aplicación lineal de $\mathbb{R}^{n}$ en $\mathbb{R}^{m}$ se expresa, fijada una base, como una matrix $m\times n$, luego identificamos $(\mathbb{R}^{n})^{*}$ con matrices $1\times n$ (en la base usual). Evidentemente hay un isomorfismo entre este conjunto y $\mathbb{R}^{n}$:
\begin{align*}
  (\mathbb{R}^{n})^{*} \cong \mathcal{M}_{1\times n}(\mathbb{R})&\cong \mathbb{R}^{n} \\
  (m_{1} \dots m_{n}) &\mapsto (m_{1}, \dots m_{n})
\end{align*}

Este hecho se generaliza para cualquier cuerpo $K$: $(K^{n})^{*}\cong K^{n}$.
\examplee

#### Cambio de coordenadas

Sea $V$ $K$-espacio vectorial, sean $A=\left\{a_{1}, \dots a_{n}\right\}, B=\left\{b_{1}, \dots b_{n}\right\}$ bases de $V$ donde $n = \dim_{K}V$.

Introducimos la siguiente notación: dada una base $B$ de $V$, $B'$ de $W$, $L\in\mathcal L(V, W)$, notaremos $[L]_{B', B}$ a la expresión matricial de $L$ en las bases $B, B'$. Si $L\in V^{*}$ notamos $[L]_{B}$.

Sabemos que la expresión de $L\in V^{*}$ en la base $B$ viene dada por su imagen por los vectores de la base, y el cambio de coordenadas es $[L]_B=[L]_A[I]_{A,B}$.

Recordamos también que el cambio de base de $v\in V$ se realiza mediante $[B]_B=[I]_{B,A}[V]_A$ y que $[I]_{B,A}=[I]_{A,B}^{-1}$. Así, llamando $S=[I]_{B,A}$ observamos que el cambio de base de los vectores asociados a las filas $[L]_B, [L]_A$ es:

$$
  [L]_{B}^t=(S^{-1})^t[L]_{A}^t
$$

\begin{prop}
Dado $V$ espacio vectorial, si $S$ es la matriz de cambio de base de $A$ a $B$ entonces la matriz de cambio de base de $V^{*}$ es $(S^{-1})^t$.
\end{prop}

\begin{lemma}
  Sea $v\in V$. Si $L(v)=0\forall L\in V^{*}$ entonces $v=0$. Como consecuencia, si $L(v_1)=L(v_2)\forall L\in V^{*}$ entonces $v_1=v_2$.
  
  \begin{proof}
    Sea $B$ base de $V$. Entonces $L(v)=[L]_B[v]_B$. Basta tomar $L_k=[0, \dots 0, \overset{(k)}{1}, 0, \dots 0]$.
  \end{proof}
\end{lemma}

## Referencias

- Linear Algebra Done Wrong