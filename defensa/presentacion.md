---
title: "Reducción de la dimensionalidad en problemas de clasificación con Deep Learning"
subtitle: "Análisis y propuesta de herramienta en R"
date: Trabajo fin de grado -- junio 2017
author: "\\textbf{Autor} Francisco David Charte Luque"
prof: "\\textbf{Tutor} Francisco Herrera Triguero"
institute: "\\includegraphics[width=\\textwidth]{images/ugrmarca}"
shortauthor: Francisco David Charte
mainfont: Fira Sans
monofont: Fira Mono
theme: metropolis
colortheme: metropolis
lang: spanish
polyglossia-lang.name: spanish
graphics: true
classoption:
  - compress
header-includes:
- \newcommand{\columnsbegin}{\begin{columns}}
- \newcommand{\columnsend}{\end{columns}}
- \definecolor{headbg}{RGB}{61, 96, 103}
- \definecolor{headfg}{RGB}{232, 239, 241}
- \definecolor{lightgrey}{RGB}{230, 230, 230}
- \setbeamercolor{headtitle}{fg=headfg,bg=headbg}
- \setbeamercolor{headnav}{fg=headfg,bg=headbg}
- \setbeamercolor{section in head/foot}{fg=headfg,bg=headbg}
- "\\defbeamertemplate*{headline}{miniframes theme no subsection}{
    \\begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,
      leftskip=.3cm,rightskip=.3cm plus1fil]{headtitle}
      {\\usebeamerfont{title in head/foot}\\insertshorttitle}
      \\hfill
      \\leavevmode{\\usebeamerfont{author in head/foot}\\insertshortauthor}
    \\end{beamercolorbox}
    \\begin{beamercolorbox}[colsep=1.5pt]{upper separation line head}
    \\end{beamercolorbox}
    \\begin{beamercolorbox}{headnav}
      \\vskip2pt\\textsc{\\insertnavigation{\\paperwidth}}\\vskip2pt
    \\end{beamercolorbox}
    \\begin{beamercolorbox}[colsep=1.5pt]{lower separation line head}
    \\end{beamercolorbox}
  }"
- "\\makeatletter\\renewcommand{\\@metropolis@frametitlestrut}{
      \\vphantom{ÁÉÍÓÚABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()1234567890}
    }\\makeatother"
- "\\defbeamertemplate*{footline}{miniframes theme no subsection}{}"
- \beamertemplatenavigationsymbolsempty
- "\\input{config.tex}"
- "\\renewcommand{\\figurename}{Figura}"
---

### Motivación

* Estudiar los fundamentos matemáticos del Deep Learning: probabilidad, teoría de la información, tensores.

* Analizar las técnicas de Deep Learning útiles para la tarea de reducción de la dimensionalidad.

* Implementar una herramienta que dé acceso a estas técnicas y permita visualizar resultados.

### Índice

\footnotesize
\tableofcontents
\normalsize

# Fundamentos matemáticos

## Probabilidad y dimensionalidad

### Probabilidad: Resultados de convergencia

\begin{exampleblock}{Lema}
\label{lm:convergencia-va} Si \(\{X_m\}\) tienen varianza finita y se verifican:
\[\exists x\in \mathbb R:\lim_{m\rightarrow +\infty} \mathrm{E}[X_m]=x,\quad \lim_{m\rightarrow +\infty} \mathrm{Var}[X_m]=0,\]
entonces se tiene que \(X_m\pconv x\).
\end{exampleblock}

\begin{exampleblock}{Teorema (de la aplicación continua)}
\label{th:cont-map-conv} Si \(g\) es continua casi por doquier, se tiene:
\begin{gather*}
  X_n\pconv X \Rightarrow g(X_n)\pconv g(X),\quad
  X_n\asconv X \Rightarrow g(X_n)\asconv g(X).
\end{gather*}

\end{exampleblock}

### Probabilidad: Maldición de la dimensionalidad
\begin{exampleblock}{Teorema}
  \label{th:dim-curse}
Sea \(\{F_{m}\}_{m\in\NN}\) una sucesión de distribuciones de
probabilidad, \(n\in \mathbb N\) y \(p\in\mathbb R^+\) fijos. Para cada
\(m\in\NN\) sean \(X_{m1},\dots,X_{mn}\sim F_m\) muestras independientes
e idénticamente distribuidas. Supongamos que tenemos una función
\(d_m:\mathrm{Dom}(F_m)\rightarrow \mathbb R^+_0\) y llamamos
\begin{equation*}
  \mathrm{DMIN}_{m}=\min_id_m(X_{mi}),\quad
  \mathrm{DMAX}_{m}=\max_id_m(X_{mi}).
\end{equation*}

Entonces, si
\(\lim_{m\rightarrow +\infty}\Var\left[\frac{d_m(X_{m1})^p}{E[d_m(X_{m1})^p]}\right]=0\)
se tiene que, para cada \(\varepsilon > 0\),
\[\lim_{m\rightarrow +\infty}\Pr{\mathrm{DMAX}_m\leq (1+\varepsilon) \mathrm{DMIN}_m}=1.\]

\end{exampleblock}

## Teoría de la información

### Teoría de la información: Entropía

\begin{exampleblock}{Definición (entropía, entropía condicionada)}
  \[H(X)=-\sum_{x\in X(\Omega)}p(x)\log p(x)~.\]

\begin{align*}
  H(Y\mid X) &= \sum_{x}p(x)H(Y\mid X=x)\\
             &= -\sum_{x}p(x)\sum_{y}p(y\mid x) \log p(y \mid x)\\
             &= -\sum_{x}\sum_{y}p(x,y) \log p(y \mid x)\\
             &= -\E_{p(x,y)} \log p(Y \mid X)~.
\end{align*}

\end{exampleblock}

### Teoría de la información: Entropía cruzada

\begin{exampleblock}{Definición (entropías relativa y cruzada)}
  \[D(p\Mid q)=\sum_{x}p(x)\log\frac{p(x)}{q(x)}=\E_{p}\left[\log\frac{p(X)}{q(X)}\right]~.\]

  \[C(p, q)=H(X) + D(p\Mid q)=\E_p\left[\log q(X)\right]~.\]

\begin{align*}
  C(p(y\mid x),q(y \mid x))=&H(Y\mid X) + D\left(p(y\mid x)\Mid q(y\mid x)\right)\\
                =&-\E_p[\log q(Y\mid X)]~.
\end{align*}
\end{exampleblock}

### Teoría de la información: Desigualdad de la información

\begin{exampleblock}{Teorema (Desigualdad de Jensen)}
  Si \(f\) es una función convexa y \(X\) es una variable aleatoria,
entonces \[\E[f(X)]\geq f(\E[X])~.\]

\end{exampleblock}

\begin{exampleblock}{Teorema (Desigualdad de la información)}
  Sean \(p\), \(q\), funciones de probabilidad de una variable aleatoria
  \(X\). Entonces, \[D(p\Mid q)\geq 0~.\]
\end{exampleblock}

**Consecuencia**: Para cualesquiera dos variables aleatorias $X, Y$ y funciones de probabilidad $p$ y $q$, $D(p(y\mid x)\Mid q(y\mid x))\geq 0$.

## Álgebra tensorial

### Álgebra tensorial: Tensor

\begin{exampleblock}{Definición (tensor)}
  Un \emph{tensor} o \emph{funcional multilineal} es una aplicación
multilineal con codominio \(\KK\),
\(F:V_1\times \dots\times V_p\rightarrow \KK\). La cantidad \(p\) se
denomina el \emph{rango} o \emph{valencia} del tensor.
\end{exampleblock}

\begin{exampleblock}{Definición (covariante/contravariante)}
  Sean \(X_1,X_2,\dots X_p,V\) espacios vectoriales y sea \(V_k\) bien
\(X_k\) o bien \(X_k^*\), para cada \(k=1,2,\dots,p\).

Decimos que  \(F\in \LL(V_1,V_2,\dots,V_p;V)\)
es una aplicación multilineal \emph{covariante} en la \(k\)-ésima variable si \(V_k=X_k\) y
\emph{contravariante} en dicha variable si \(V_k=X_k^*\).
\end{exampleblock}

### Álgebra tensorial: Casos particulares

\begin{exampleblock}{Ejemplos}
Algunos casos particulares de tensores, para observar que generalizan los objetos del álgebra lineal:
\begin{itemize}
\item Dado un espacio vectorial \(V\), un funcional \(f\in V^*\) es un
  tensor 1-covariante.
  \item Un vector \(v\in V\), visto en el doble dual
    \(V^{**}\), es un tensor 1-contravariante.
    \item Por convención, se dice que una constante $\lambda\in\KK$ es un tensor de tipo \((0,0)\).
\end{itemize}
\end{exampleblock}

### Álgebra tensorial: Tensores en aprendizaje automático

* Las componentes de un tensor dependen de la base escogida. Para recorrerlas, se necesitan tantos índices como rango tenga.

* En aprendizaje, se le llama \emph{tensor} de rango $p$ a un objeto $T\in \KK^{d_1d_2 \dots d_p}$.

* No se suele hacer uso de sus propiedades algebraicas.

* Las operaciones de cálculo de tensores hacen uso eficiente de la memoria.

# Deep Learning

## Aprendizaje automático

### Aprendizaje automático: Clasificación

* Tarea de **aprendizaje supervisado** que consiste en aprender acerca de la etiqueta o clase de una secuencia de muestras clasificadas, para después ser capaz de **predecir** el valor de dicha etiqueta en nuevas instancias sin clasificar.

* Dado un problema de clasificación $\left(\mathcal A, L, D\right)$, un
\emph{clasificador} es una aplicación $c:\mathcal A\rightarrow L$.
    * $\mathcal A$ es el espacio de atributos
    * $L$ es un conjunto finito de etiquetas
    * $D$ es un conjunto finito de elementos de $\mathcal A\times L$.

* Se busca el mejor $c$ para una o varias métricas de evaluación.

* Puede ser binaria, multiclase, multietiqueta o multidimensional.

### Aprendizaje automático: Reducción de dimensionalidad

* Al aumentar la dimensionalidad de los conjuntos de datos se **pierde significatividad** en las distancias.

* Se puede reducir la dimensionalidad manteniendo la información útil mediante dos mecanismos:
    a. **Construcción de características**
    b. Selección de características
    
### Aprendizaje automático: Gradiente descendente

* Consiste en, a cada paso determinado por un
punto $x$ del dominio, consultar el gradiente de $f$ en $x$,
$\nabla f(x)$, y ``saltar'' una cantidad $\varepsilon>0$ en su
dirección y en el sentido contrario: $$x' = x - \varepsilon\nabla f(x)$$
Al escalar $\varepsilon$ se le suele llamar \emph{tasa de
  aprendizaje}.

* El algoritmo termina cuando $\nabla f(x)$ es el vector cero o muy
cercano a cero

---

\begin{figure}[hbtp]
  \centering
  \includegraphics[width=0.45\textwidth]{images/gradient_ascent_contour.png}
  \includegraphics[width=0.45\textwidth]{images/gradient_ascent_surface.png}
  \caption{\label{fig:grad-desc}Visualización de la técnica de gradiente descendente, en este caso, buscando un máximo de la función $F(x,y)=\sin\left(\frac{1}{2} x^2 - \frac{1}{4} y^2 + 3 \right) \cos(2 x+1-e^y)$. Imágenes de Wikimedia Commons en dominio público}
\end{figure}

## Deep Learning

### Deep Learning: Neuronas artificiales

\columnsbegin
\column{0.5\textwidth}

\begin{figure}[hbtp]
  \centering
  \includegraphics[width=\textwidth]{images/neurona_biologica}
  \caption[Neurona biológica]{Ilustración de una neurona biológica, indicando las equivalencias con la neurona artificial}
  \label{fig:neuron}
\end{figure}

\column{0.5\textwidth}
\begin{figure}[hbtp]
  \centering
  \small
\begin{tikzpicture}[scale=0.16]
\tikzstyle{every node}+=[inner sep=0pt]
\draw [black] (39.4,-29) circle (5.5);
\draw (39.4,-29) node {$g(\Tr wx+b)$};
%\draw (51.6,-29) node {$f$};
\draw [black] (44.9,-29) -- (48.6,-29);
\fill [black] (48.6,-29) -- (47.8,-28.5) -- (47.8,-29.5);

\draw (15.9,-20.2) node {$x_1$};
\draw (15.9,-36.7) node {$x_m$};
\draw (15.9,-30.9) node {$\vdots$};
\draw (15.9,-26) node {$x_2$};
\draw [black] (18.66,-21.37) -- (33.84,-27.83);
\fill [black] (33.84,-27.83) -- (33.3,-27.05) -- (32.91,-27.97);
\draw (24.55,-25.12) node [below] {$w_1$};
\draw [black] (18.87,-26.43) -- (33.63,-28.57);
\fill [black] (33.63,-28.57) -- (32.91,-27.96) -- (32.77,-28.95);
\draw (25.63,-28.16) node [below] {$w_2$};
\draw [black] (18.71,-35.65) -- (33.79,-30.05);
\fill [black] (33.79,-30.05) -- (32.86,-29.86) -- (33.21,-30.79);
\draw (28.87,-33.42) node [below] {$w_m$};
\end{tikzpicture}
\normalsize

  \caption[Neurona artificial]{Una neurona artificial con $m$ entradas y función de activación $g$}
  \label{fig:art-neuron}
\end{figure}
\columnsend

### Deep Learning: Redes prealimentadas profundas

\columnsbegin
\column{0.5\textwidth}
Representan:
$$  f^{*}(x)\approx f(x;\theta,w)=\Tr{\phi(x;\theta)}w, $$
donde $\phi$ es una composición de funciones y transformaciones lineales.

\column{0.5\textwidth}
\begin{figure}[hbtp]
  \centering
\begin{tikzpicture}[scale=0.12]
\tikzstyle{every node}+=[inner sep=0pt]
\draw [black] (21.5,-13.4) circle (3);
\draw [black] (21.5,-23.4) circle (3);
\draw [black] (21.5,-33.1) circle (3);
\draw [black] (36.4,-7.6) circle (3);
\draw [black] (36.4,-17.8) circle (3);
\draw [black] (36.4,-28.2) circle (3);
\draw [black] (36.4,-39.6) circle (3);
\draw [black] (50.6,-23.4) circle (3);
\draw [black] (24.35,-32.16) -- (33.55,-29.14);
\fill [black] (33.55,-29.14) -- (32.63,-28.91) -- (32.95,-29.86);
\draw [black] (24.25,-34.3) -- (33.65,-38.4);
\fill [black] (33.65,-38.4) -- (33.12,-37.62) -- (32.72,-38.54);
\draw [black] (23.59,-30.95) -- (34.31,-19.95);
\fill [black] (34.31,-19.95) -- (33.39,-20.17) -- (34.11,-20.87);
\draw [black] (23.01,-30.51) -- (34.89,-10.19);
\fill [black] (34.89,-10.19) -- (34.05,-10.63) -- (34.91,-11.13);
\draw [black] (23.56,-21.22) -- (34.34,-9.78);
\fill [black] (34.34,-9.78) -- (33.43,-10.02) -- (34.16,-10.71);
\draw [black] (24.31,-22.34) -- (33.59,-18.86);
\fill [black] (33.59,-18.86) -- (32.67,-18.67) -- (33.02,-19.6);
\draw [black] (24.36,-24.32) -- (33.54,-27.28);
\fill [black] (33.54,-27.28) -- (32.94,-26.56) -- (32.63,-27.51);
\draw [black] (23.53,-25.61) -- (34.37,-37.39);
\fill [black] (34.37,-37.39) -- (34.2,-36.46) -- (33.46,-37.14);
\draw [black] (24.3,-12.31) -- (33.6,-8.69);
\fill [black] (33.6,-8.69) -- (32.68,-8.51) -- (33.04,-9.44);
\draw [black] (24.38,-14.25) -- (33.52,-16.95);
\fill [black] (33.52,-16.95) -- (32.9,-16.24) -- (32.61,-17.2);
\draw [black] (23.63,-15.51) -- (34.27,-26.09);
\fill [black] (34.27,-26.09) -- (34.06,-25.17) -- (33.35,-25.88);
\draw [black] (22.98,-16.01) -- (34.92,-36.99);
\fill [black] (34.92,-36.99) -- (34.96,-36.05) -- (34.09,-36.54);
\draw [black] (38.41,-9.83) -- (48.59,-21.17);
\fill [black] (48.59,-21.17) -- (48.43,-20.24) -- (47.69,-20.91);
\draw [black] (39.19,-18.9) -- (47.81,-22.3);
\fill [black] (47.81,-22.3) -- (47.25,-21.54) -- (46.88,-22.47);
\draw [black] (39.24,-27.24) -- (47.76,-24.36);
\fill [black] (47.76,-24.36) -- (46.84,-24.14) -- (47.16,-25.09);
\draw [black] (38.38,-37.34) -- (48.62,-25.66);
\fill [black] (48.62,-25.66) -- (47.72,-25.93) -- (48.47,-26.59);
\end{tikzpicture}
\caption{\label{fig:dfnn}Ilustración ejemplificando una red neuronal prealimentada de tres capas}
\end{figure}
\columnsend

### Deep Learning: Unidades y algoritmos

* Unidades: ocultas y de salida (determinan la función de coste)

* Funciones de activación: lineal, lineal rectificada (ReLU), sigmoidal, *softmax*, tangente hiperbólica, *softplus*...

* Entrenamiento:
    * Evaluación de la red por los datos de entrada: propagación hacia adelante
    * Cálculo de gradientes: propagación hacia atrás
    * Optimización: gradiente descendente estocástico, AdaGrad, RMSProp, Adam

<!--
### Deep Learning: Propagación hacia atrás

  \begin{figure}[hbtp]
\centering\footnotesize
\begin{tikzpicture}[scale=0.14]
\tikzstyle{every node}+=[inner sep=0pt]
\draw [black] (34,-24.7) circle (3);
\draw [black] (34,-38.8) circle (3);
\draw [black] (48.7,-33) circle (3);
\draw (15.2,-24.7) node {$x_1$};
\draw (15.2,-38.8) node {$x_2$};
\draw (61.1,-33) node {$f$};
\draw (23.8,-13.6) node {$1$};
\draw (41.5,-13.6) node {$1$};
\draw [black] (36.79,-37.7) -- (45.91,-34.1);
\fill [black] (45.91,-34.1) -- (44.98,-33.93) -- (45.35,-34.86);
\draw (43.4,-36.44) node [below] {$w_{12}^{(2)}$};
\draw [black] (36.61,-26.18) -- (46.09,-31.52);
\fill [black] (46.09,-31.52) -- (45.64,-30.7) -- (45.15,-31.57);
\draw (39.21,-29.35) node [below] {$w_{11}^{(2)}$};
\draw [black] (17.6,-26.5) -- (31.6,-37);
\fill [black] (31.6,-37) -- (31.26,-36.12) -- (30.66,-36.92);
\draw (19.45,-29.25) node [below] {$w_{21}^{(1)}$};
\draw [black] (17.6,-37) -- (31.6,-26.5);
\fill [black] (31.6,-26.5) -- (30.66,-26.58) -- (31.26,-27.38);
\draw (22.75,-33.50) node [below] {$w_{12}^{(1)}$};
\draw [black] (51.7,-33) -- (58.1,-33);
\fill [black] (58.1,-33) -- (57.3,-32.5) -- (57.3,-33.5);
\draw [black] (25.83,-15.81) -- (31.97,-22.49);
\fill [black] (31.97,-22.49) -- (31.8,-21.56) -- (31.06,-22.24);
\draw (31.36,-16.61) node [left] {$b_1^{(1)}$};
\draw [black] (42.54,-16.41) -- (47.66,-30.19);
\fill [black] (47.66,-30.19) -- (47.85,-29.26) -- (46.91,-29.61);
\draw (44.34,-24.11) node [left] {$b_1^{(2)}$};
\draw [black] (24.93,-16.38) -- (32.87,-36.02);
\fill [black] (32.87,-36.02) -- (33.04,-35.09) -- (32.11,-35.47);
\draw (25.16,-20.1) node [left] {$b_2^{(1)}$};
\draw [black] (18.2,-24.7) -- (31,-24.7);
\fill [black] (31,-24.7) -- (30.2,-24.2) -- (30.2,-25.2);
\draw (24.6,-25.2) node [below] {$w_{11}^{(1)}$};
\draw [black] (18.2,-38.8) -- (31,-38.8);
\fill [black] (31,-38.8) -- (30.2,-38.3) -- (30.2,-39.3);
\draw (24.6,-39.3) node [below] {$w_{22}^{(1)}$};
\end{tikzpicture}\normalsize
\end{figure}\footnotesize
\begin{gather*}
f(x_1,x_2;\theta)=\\g\left(w_{11}^{(2)}g\left(w_{11}^{(1)}x_{1}+w_{12}^{(1)}x_2+b_1^{(1)}\right)+w_{12}^{(2)}g\left(w_{21}^{(1)}x_1+w_{22}^{(1)}x_2+b_2^{(1)}\right)+b_1^{(2)}\right).
\end{gather*}\normalsize

---

\footnotesize
\begin{alignat*}{3}
  \frac{\partial f}{\partial w_{11}^{(1)}}(x_1,x_2;\theta)&=\alpha w_{11}^{(2)}\beta x_1,\quad&
  \frac{\partial f}{\partial w_{12}^{(1)}}(x_1,x_2;\theta)&=\alpha w_{11}^{(2)}\beta x_2,\\
  \frac{\partial f}{\partial w_{21}^{(1)}}(x_1,x_2;\theta)&=\alpha w_{12}^{(2)}\gamma x_1,\quad&
  \frac{\partial f}{\partial w_{22}^{(1)}}(x_1,x_2;\theta)&=\alpha w_{12}^{(2)}\gamma x_2,\\
  \frac{\partial f}{\partial b_{1}^{(1)}}(x_1,x_2;\theta)&=\alpha w_{11}^{(2)}\beta, \quad&
  \frac{\partial f}{\partial b_{2}^{(1)}}(x_1,x_2;\theta)&=\alpha w_{12}^{(2)}\gamma, \\
  \frac{\partial f}{\partial w_{11}^{(2)}}(x_1,x_2;\theta)&=\alpha g(w_{11}^{(1)}x_{1}+w_{12}^{(1)}x_2 + b_1^{(1)}),&&\\
  \frac{\partial f}{\partial w_{12}^{(2)}}(x_1,x_2;\theta)&=\alpha g(w_{21}^{(1)}x_{1}+w_{22}^{(1)}x_2 + b_2^{(1)}),&\quad
  \frac{\partial f}{\partial b_{1}^{(2)}}(x_1,x_2;\theta)&=\alpha,
\end{alignat*}\footnotesize
\begin{align*}
  \alpha&=g'\left(w_{11}^{(2)} g\left(w_{11}^{(1)}x_{1}+w_{12}^{(1)}x_2+b_1^{(1)}\right) + w_{12}^{(2)} g\left(w_{21}^{(1)}x_1+w_{22}^{(1)}x_2+b_2^{(1)}\right)+b_1^{(2)}\right)\\
  \beta&=g'\left(w_{11}^{(1)}x_{1}+w_{12}^{(1)}x_2+b_1^{(1)}\right)\\
  \gamma&=g'\left(w_{21}^{(1)}x_{1}+w_{22}^{(1)}x_2+b_2^{(1)}\right)
\end{align*}
\normalsize

### Deep Learning: Gradiente descendente estocástico

#### Gradiente descendente estocástico, iteración $k$-ésima
\begin{algorithmic}
  \REQUIRE{Tasa de aprendizaje $\varepsilon_k$}
  \REQUIRE{Parámetro inicial $\theta$}
  \WHILE{no se alcanza criterio de parada}
  \STATE{Escoger un minilote de $m$ instancias del conjunto de entrenamiento $x^{(1)},\dots,x^{(m)}$ con correspondientes objetivos $y^{(i)}$}
  \STATE{Calcular estimador del gradiente: $\hat g\gets \frac 1 m \nabla \sum_i L(f(x^{(i)}; \theta),y^{(i)})$}
  \STATE{Actualizar parámetro: $\theta\gets\theta - \varepsilon_k\hat g$}
  \ENDWHILE
\end{algorithmic}

Variantes de SGD: SGD con momento, AdaGrad, RMSProp, Adam
-->

### Deep Learning: Estructuras profundas no supervisadas

\columnsbegin
\column{0.5\textwidth}

\begin{figure}[hbtp]
  \centering
  
\begin{tikzpicture}[scale=0.1]
\tikzstyle{every node}+=[inner sep=0pt]
\draw [black] (13.9,-15.6) circle (3);
\draw [black] (13.9,-23.8) circle (3);
\draw [black] (13.9,-31.9) circle (3);
\draw [black] (13.9,-39.6) circle (3);
\draw [black] (13.9,-47.6) circle (3);
\draw [black] (29.3,-23.8) circle (3);
\draw [black] (29.3,-31.9) circle (3);
\draw [black] (29.3,-39.6) circle (3);
\draw (13.9,-10.4) node {$v$};
\draw (29.3,-10.4) node {$h$};
\draw [black] (16.55,-17.01) -- (26.65,-22.39);
\draw [black] (15.96,-17.78) -- (27.24,-29.72);
\draw [black] (15.52,-18.12) -- (27.68,-37.08);
\draw [black] (16.9,-23.8) -- (26.3,-23.8);
\draw [black] (16.56,-25.2) -- (26.64,-30.5);
\draw [black] (15.99,-25.95) -- (27.21,-37.45);
\draw [black] (16.56,-30.5) -- (26.64,-25.2);
\draw [black] (16.9,-31.9) -- (26.3,-31.9);
\draw [black] (16.58,-33.24) -- (26.62,-38.26);
\draw [black] (15.99,-37.45) -- (27.21,-25.95);
\draw [black] (16.58,-38.26) -- (26.62,-33.24);
\draw [black] (16.9,-39.6) -- (26.3,-39.6);
\draw [black] (15.53,-45.08) -- (27.67,-26.32);
\draw [black] (16,-45.46) -- (27.2,-34.04);
\draw [black] (16.56,-46.22) -- (26.64,-40.98);
\end{tikzpicture}
  \caption[Máquina de Boltzmann restringida]{Máquina de Boltzmann restringida}
  \label{fig:rbm}
\end{figure}

\column{0.5\textwidth}


\begin{figure}[hbtp]
  \centering
\begin{tikzpicture}[scale=0.1]
\tikzstyle{every node}+=[inner sep=0pt]
\draw [black] (21.5,-13.4) circle (3);
\draw [black] (21.5,-23.4) circle (3);
\draw [black] (21.5,-33.1) circle (3);
\draw [black] (36.4,-23.4) circle (3);
\draw [black] (36.4,-33.1) circle (3);
\draw [black] (50.6,-23.4) circle (3);
\draw [black] (21.5,-43) circle (3);
\draw [black] (50.6,-33.1) circle (3);
\draw [black] (50.6,-43) circle (3);
\draw [black] (50.6,-13.4) circle (3);
\draw [black] (24.5,-33.1) -- (33.4,-33.1);
\fill [black] (33.4,-33.1) -- (32.6,-32.6) -- (32.6,-33.6);
\draw [black] (24.01,-31.46) -- (33.89,-25.04);
\fill [black] (33.89,-25.04) -- (32.94,-25.05) -- (33.49,-25.89);
\draw [black] (24.5,-23.4) -- (33.4,-23.4);
\fill [black] (33.4,-23.4) -- (32.6,-22.9) -- (32.6,-23.9);
\draw [black] (24.01,-25.04) -- (33.89,-31.46);
\fill [black] (33.89,-31.46) -- (33.49,-30.61) -- (32.94,-31.45);
\draw [black] (23.99,-15.07) -- (33.91,-21.73);
\fill [black] (33.91,-21.73) -- (33.52,-20.87) -- (32.97,-21.7);
\draw [black] (23.31,-15.79) -- (34.59,-30.71);
\fill [black] (34.59,-30.71) -- (34.51,-29.77) -- (33.71,-30.37);
\draw [black] (39.4,-23.4) -- (47.6,-23.4);
\fill [black] (47.6,-23.4) -- (46.8,-22.9) -- (46.8,-23.9);
\draw [black] (38.88,-31.41) -- (48.12,-25.09);
\fill [black] (48.12,-25.09) -- (47.18,-25.13) -- (47.74,-25.96);
\draw [black] (24,-41.34) -- (33.9,-34.76);
\fill [black] (33.9,-34.76) -- (32.96,-34.79) -- (33.51,-35.62);
\draw [black] (23.32,-40.61) -- (34.58,-25.79);
\fill [black] (34.58,-25.79) -- (33.7,-26.12) -- (34.5,-26.73);
\draw [black] (38.85,-21.67) -- (48.15,-15.13);
\fill [black] (48.15,-15.13) -- (47.21,-15.18) -- (47.78,-16);
\draw [black] (38.88,-25.09) -- (48.12,-31.41);
\fill [black] (48.12,-31.41) -- (47.74,-30.54) -- (47.18,-31.37);
\draw [black] (38.16,-25.83) -- (48.84,-40.57);
\fill [black] (48.84,-40.57) -- (48.78,-39.63) -- (47.97,-40.22);
\draw [black] (38.15,-30.67) -- (48.85,-15.83);
\fill [black] (48.85,-15.83) -- (47.97,-16.19) -- (48.78,-16.78);
\draw [black] (39.4,-33.1) -- (47.6,-33.1);
\fill [black] (47.6,-33.1) -- (46.8,-32.6) -- (46.8,-33.6);
\draw [black] (38.86,-34.82) -- (48.14,-41.28);
\fill [black] (48.14,-41.28) -- (47.77,-40.42) -- (47.2,-41.24);
\end{tikzpicture}
\caption{\label{fig:autoencoder}Autoencoder} 
\end{figure}

Tipos: **infracompleto**, disperso, con eliminación de ruido, contractivo.


\columnsend


# La herramienta Ruta

## Dependencias

### Dependencias: R y MXNet

* R: Lenguaje de programación dirigido al **tratamiento de datos**, con plataforma de paquetes: CRAN (bibliotecas para lectura, procesamiento y visualización de datos).

* R cuenta con estructuras de datos como *data.frame* y varias orientaciones a objetos.

* MXNet: Biblioteca de algoritmos de Deep Learning (optimizadores, funciones de activación, propagación hacia adelante y hacia atrás) escrita en **C++** (frente a TensorFlow o Theano en Python), paralelizada en CPU o GPU y con APIS para Python, Scala y **R**

## Paquete Ruta

### Ruta: Introducción

* Paquete de R para uso de estructuras no supervisadas de Deep Learning

* Un prototipo se presentó en CAEPIA 2016

* Cuenta con licencia libre (GPL v3), integración continua y sitio web ([`http://ruta.software`](http://ruta.software))

\begin{figure}[hbtp]
  \centering
  \includegraphics[width=0.6\textwidth]{images/responsive_web.png}
  \label{fig:rutaweb}
\end{figure}

\centering

### Ruta: Tareas

* Se componen de un conjunto de datos y varios metadatos que aportan información acerca del mismo.
* Se construyen con `ruta.makeTask`.

. . .

\small

~~~R
task <- ruta.makeUnsupervisedTask("iris", data = iris, cl = 5)
~~~

\normalsize

### Ruta: Algoritmos de aprendizaje

* Ruta cuenta con autoencoders y RBMs.
* Se generan con `ruta.makeLearner`, que acepta los parámetros de función de activación.
* Se entrenan con `train`, que acepta múltiples argumentos para el optimizador: `sgd`, `adagrad`, `rmsprop`, `adam`.

. . .

\small

~~~R
ae <- ruta.makeLearner("autoencoder",
                       hidden = c(4, 2, 4),
                       activation = "leaky")
args <- ruta.pretrain(ae, task)
model <- train(ae, task, optimizer = "adagrad", 
               epochs = 80, learning.rate = 0.02, 
               initializer.scale = 2, initial.args = args)
~~~

\normalsize

### Ruta: Modelos entrenados

* Se obtienen las codificaciones con `ruta.deepFeatures`.
* `ruta.layerOutputs` extrae salidas de cualquier capa.
* `predict` obtiene las reconstrucciones para entradas dadas.

. . .

~~~R
internals <- ruta.deepFeatures(model, task)
~~~

## Visualización con Rutavis

### Rutavis: Funcionalidad

\columnsbegin
\column{0.5\textwidth}

* Utiliza Plotly para generar **gráficos interactivos** de la capa interna de un autoencoder.

* Incluye una **interfaz de usuario web** con la que interaccionar con Ruta sin programar.

\column{0.5\textwidth}
\begin{figure}[hbtp]
  \centering
  \includegraphics[width=0.8\textwidth]{images/rutavis_iris.png}
  \caption{\label{fig:irisplot}Gráfico de la codificación de los datos de entrada mediante la capa interna del autoencoder}
\end{figure}
\columnsend

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/1}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/2}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/3}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/4}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/5}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/6}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/7}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/8}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/9}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/10}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/11}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/12}

---

\hspace*{-7mm}\includegraphics[width=\paperwidth]{images/demo/13}

# Conclusiones

### Conclusiones

* Hemos estudiado las técnicas no supervisadas de deep learning desde sus orígenes matemáticos, hasta una implementación práctica y con muchas facilidades para el usuario.

* Nuevas vías de trabajo: 
    * Más variantes de autoencoders
    * Más visualizaciones
    * Comparaciones con otros métodos de reducción de la dimensionalidad

### Bibliografía fundamental

\begin{thebibliography}{9}

\bibitem{goodfellow2016}
  Ian Goodfellow, Yoshua Bengio y Aaron Courville. 
  \emph{Deep Learning}. http://www.deeplearningbook.org . MIT Press, 2016.

\bibitem{treil2013}
  Sergei Treil. 
  \emph{Linear algebra done wrong}. MTM, 2013.

\bibitem{cover2012}
  Thomas M Cover y Joy A Thomas. 
  \emph{Elements of information theory}. John Wiley \& Sons, 2012.
  
\bibitem{beyer1999}
  Kevin Beyer y col. 
  \emph{When is “nearest neighbor” meaningful?}
  En: International conference on database theory. Springer. 1999, págs. 217-235.

\end{thebibliography}
