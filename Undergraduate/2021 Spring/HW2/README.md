# Introducción

En esta tarea replicaremos parte de los resultados del artículo “A contribution to the empirics of economic growth” de Mankiw, Romer y Weil (MRW), publicado en The Quarterly Journal of Economics en 1992. El archivo mrw.dta contiene los datos utilizados en el artículo para 121  países:

- number :Identificador numérico del país
- country : Nombre del país
- n : Dummy igual a 1 si el país pertenece a la submuestra de países no petroleros, 0 en otro caso
- i: Dummy igual a 1 si el país pertenece a la submuestra de países intermedios, 0 en otro caso o
- Dummy: igual a 1 si el país pertenece a la submuestra de países de la OECD, 0 en otro caso
- rgdpw60: PIB real por trabajador en 1960
- rgdpw85 PIB real por trabajador en 1985
- popgrowth : Crecimiento promedio anual de la población en edad de trabajar entre 1960 y 1985
- i_y : Inversión real como porcentaje del PIB (promedio anual del periodo 1960-1985)
- school: Porcentaje de la población en edad de trabajar con educación secundaria (promedio anual del periodo 1960-1985)

# Preguntas

## Primera parte
Como primer paso MRW estiman el modelo simple de crecimiento económico de Solow. La ecuación de referencia para la primera parte del análisis es:

ln (𝑌/𝐿) = 𝛽0 + 𝛽1 ln(𝑠) + 𝛽2 ln(𝑛 + 𝑔 + 𝛿) + 𝑢

donde 𝑌/𝐿 representa el producto por trabajador, 𝑠 = 𝐼/𝑌 la tasa de inversión en capital físico, 𝑛 la tasa de crecimiento de la población en edad de trabajar, 𝑔 la tasa de cambio tecnológico y 𝛿 la tasa de depreciación.

1. Estime la ecuación por MCO para cada submuestra de países. Puede suponer que 𝑔 + 𝛿= 0.05 (como hacen MRW) y utilizar como variable dependiente el logaritmo del PIB  real por trabajador en 1985. Hint: no olvide dividir las variables i_y y popgrowth entre 100 antes de estimar. Compruebe que es capaz de replicar las estimaciones de la tabla 1 en MRW (1992).

2. Interprete los coeficientes estimados para las tres submuestras. ¿Son los coeficientes individualmente significativos al 5%? ¿Explican la inversión y el crecimiento de la población una parte importante de la variación en el producto por trabajador? 

3. Contraste la hipótesis de que los coeficientes son iguales en magnitud pero de distinto signo (como predice el modelo) para cada una de las submuestras (𝐻0: 𝛽1 + 𝛽2 = 0). ¿Puede rechazar la hipótesis nula al 5%?





## Segunda parte
En la segunda parte del análisis, MRW estiman un modelo de Solow que incluye capital humano. La ecuación de referencia es: 

ln (𝑌/𝐿) = 𝛽0 + 𝛽1 ln(𝑛 + 𝑔 + 𝛿) + 𝛽2 ln(𝑠𝑘) + 𝛽3ln(𝑠ℎ) + 𝑢

donde 𝑠𝑘 = 𝐼/𝑌 es la tasa de inversión en capital físico y 𝑠ℎ la tasa de acumulación en capital humano. MRW usan la variable school como medida de 𝑠ℎ.

1. Estime la nueva ecuación de referencia para cada una de las submuestras. Ayuda: no olvide dividir la variable school entre 100 antes de estimar. Compruebe que es capaz de replicar las estimaciones de la tabla 2 en MRW (1992).

2. Interprete el coeficiente estimado de la variable ln(school). ¿Es el coeficiente estadísticamente significativo al 5%?

3. Contraste la hipótesis de que la suma de los tres coeficientes es cero (como predice el modelo) para cada una de las submuestras (𝐻0: 𝛽1 + 𝛽2 + 𝛽3 = 0). ¿Puede rechazar la hipótesis nula al 5%?




## Tercera parte

MRW también utilizan análisis de regresión para estudiar la idea de convergencia en el marco del modelo de Solow.

1. El primer paso es analizar la convergencia incondicional. Este tipo de convergencia implica que la tasa de crecimiento del producto por trabajador debe estar negativamente correlacionada con el nivel de producto por trabajador inicial. Estime la ecuación de convergencia incondicional para cada submuestra usando 1960 como año de referencia inicial:

ln (𝑌1985/𝐿1985) − ln (𝑌1960/𝐿196𝑂) = 𝛽0 + 𝛽1 ln (𝑌1960/𝐿196𝑂) + 𝑢

Grafique también la relación entre la tasa de crecimiento y el log del producto por trabajador en 1960. Interprete los resultados. ¿Hay evidencia de convergencia incondicional?

2. Ahora analicemos la convergencia condicional. Para eso agregamos a la ecuación anterior ln(𝑛 + 𝑔 + 𝛿), ln(𝑠𝑘) y ln(𝑠ℎ) como variables explicativas. Estime la ecuación de convergencia condicional para cada submuestra de países. Interprete los resultados y discuta si hay evidencia de convergencia condicional.

3. Se cree que el efecto de la tasa de inversión en capital físico podría ser complementario al de la tasa de acumulación en capital humano. Cree la interacción entre ln(𝑠𝑘) y ln(𝑠ℎ) en Stata y agréguela como variable explicativa adicional en la ecuación de convergencia condicional de la pregunta anterior. ¿Encuentra evidencia a favor de la complementariedad que se sugiere (es el coeficiente de la interacción positivo y estadísticamente significativo)? Discutir para cada submuestra de países.

4. Implemente el test de heteroscedasticidad de White y discuta los resultados para cada submuestra de países. ¿Se mantienen los resultados encontrados en III usando errores estándar robustos a heteroscedasticidad? Ayuda: use el comando imtest,white

5. Grafique los residuos de la regresión anterior (con errores estándar robustos) como función de la interacción entre la tasa de inversión en capital físico y la tasa de acumulación en capital humano. Interprete las figuras para cada submuestra. Ayuda: use el comando avplot



