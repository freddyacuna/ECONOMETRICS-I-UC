****IMPORTANDO DATA

use "https://github.com/freddyacuna/Econometrics-UC/raw/master//Undergraduate/2021%20Spring/HW2/mrw.dta", clear

***** Creando variables

gen delta_gamma = 0.05
gen ln_gdp_60 = ln(rgdpw60)
gen ln_gdp_85 = ln(rgdpw85)
gen ln_gdp_growth =  ln(rgdpw85) - ln(rgdpw60)
gen ln_inv_gdp = ln(i_y/100)
gen ln_ndg = ln(popgrowth/100 + delta_gamma)
gen ln_school = ln(school/100)


********************************************
***** P R E G U N T A 1
********************************************


	*******************************************
			******* P R E G U N T A 	i
	*******************************************
reg ln_gdp_85 ln_inv_gdp ln_ndg if n==1, robust	
reg ln_gdp_85 ln_inv_gdp ln_ndg if i==1, robust	
reg ln_gdp_85 ln_inv_gdp ln_ndg if o==1, robust	
	
	*******************************************
			******* P R E G U N T A 	ii
	*******************************************
					*Interpretación de beta_1
					
*nivel-nivel ----> delta y = beta_1 delta X 

*nivel-log	----> delta y = (beta_1/100 )% delta X 

*log-nivel	----> % delta y = 100* beta_1 delta X
 
 /*
 
 "y" aumenta en beta_1*100% por cada unidad más de "x"
 
 */
 
 
*log-log	----> % delta y = beta_1 % delta X 

/*
elasticidad. el coeficiente de log(x_1) es la elasticidad estimada
de "y" respecto a "x_1". Esto implica que por cada aumento de 1% en las x_1 de la empresa hay un aumento de aproximadamente beta_1 % en el "y" de la persona.
*/
	
	*******************************************
			******* P R E G U N T A 	iii
	*******************************************
	
quietly  reg ln_gdp_85 ln_inv_gdp ln_ndg if n==1, robust
test ln_inv_gdp+ln_ndg=0

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if i==1, robust
test ln_inv_gdp+ln_ndg=0


quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if o==1, robust
test ln_inv_gdp+ln_ndg=0


	*******************************************
			******* P R E G U N T A 	SINTESIS
	*******************************************
quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if n==1, robust
eststo solow_noil

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if i==1, robust
eststo solow_int

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if o==1, robust
eststo solow_oecd

*html
esttab solow_noil solow_int solow_oecd, label r2 se scalar(rmse) title("Dependent variable: Ln GDP per worker in 1985") mtitle("Non-oil" "Intermediate" "OECD") html

/*

PROS:

- Los signos de los coeficientes de ahorro y crecimiento poblacional son correctos

- La hipótesis de que los coeficientes de ln⁡ (s) y ln⁡ (n + g + δ) son iguales en la magnitud y el signo opuesto NO son rechazados por los datos

- Las diferencias en el ahorro y el crecimiento de la población explican una gran fracción de las diferencias en el producto per cápita entre países (Adj R2^ es 0,59).

CONTRAS:

- La magnitud de los coeficientes de ahorro y crecimiento demográfico está sobrevalorada. El α \ alphaα implícito es mayor que 1/3.

*/

********************************************
***** P R E G U N T A 2
********************************************


	*******************************************
			******* P R E G U N T A 	i
	*******************************************
reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if n==1, robust
reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if i==1, robust
reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if o==1, robust
	
	
	
	
	*******************************************
			******* P R E G U N T A 	ii
	*******************************************
	
/*
elasticidad. el coeficiente de log(x_1) es la elasticidad estimada
de "y" respecto a "x_1". Esto implica que por cada aumento de 1% en las x_1 de la empresa hay un aumento de aproximadamente beta_1 % en el "y" de la persona.
*/

	
	
	*******************************************
			******* P R E G U N T A 	iii
	*******************************************

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if n==1, robust
test ln_inv_gdp+ln_ndg+ln_school=0

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if i==1, robust
test ln_inv_gdp+ln_ndg+ln_school=0

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if o==1, robust
test ln_inv_gdp+ln_ndg+ln_school=0
	
	
	*******************************************
			******* P R E G U N T A 	SINTESIS
	*******************************************

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if n==1, robust
eststo augsolow_noil

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if i==1, robust
eststo augsolow_int

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if o==1, robust
eststo augsolow_oecd

*html
esttab augsolow_noil augsolow_int augsolow_oecd, label r2 se scalar(rmse) title("Dependent variable: Ln GDP per worker in 1985") mtitle("Non-oil" "Intermediate" "OECD") html

/*
- El capital humano es significativo en las tres muestras

- Reduce el tamaño del coeficiente sobre capital físico

- Mejora el ajuste de la regresión. Casi el 80% en las muestras intermedias y no oleosas

- Los coeficientes de ln⁡ (I / Y), ln⁡ (ESCUELA) ln (ESCUELA) e ln (n + g + δ) suma a cero

- Para muestras intermedias y no petroleras, α \ alphaα y β \ betaβ son aproximadamente un tercio y son altamente significativas

- Para la muestra de la OCDE, las estimaciones son menos precisas.
*/


********************************************
***** P R E G U N T A 3
********************************************


	*******************************************
			******* P R E G U N T A 	i (Unconditional Convergence)
	*******************************************
	
quietly reg ln_gdp_growth ln_gdp_60 if n==1, robust
scalar speed_ucc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_ucc
scalar halfLife_ucc = log(2)/speed_ucc
quietly estadd scalar halfLife_ucc
eststo ucc_noil

quietly reg ln_gdp_growth ln_gdp_60 if i==1, robust
scalar speed_ucc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_ucc
scalar halfLife_ucc = log(2)/speed_ucc
quietly estadd scalar halfLife_ucc
eststo ucc_int

quietly reg ln_gdp_growth ln_gdp_60 if o==1, robust
scalar speed_ucc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_ucc
scalar halfLife_ucc = log(2)/speed_ucc
quietly estadd scalar halfLife_ucc
eststo ucc_oecd	
	
*%html
esttab ucc_noil ucc_int ucc_oecd, label se stats(r2 speed_ucc halfLife_ucc) title("Dependent variable: Growth GDP per worker 1960-1985") mtitle("Non-oil" "Intermediate" "OECD") html	
	
/*	

- Para las muestras intermedias y no petroleras, los países pobres no tienen tendencia a crecer más rápido en promedio que los países ricos.

- Para la muestra de la OCDE, existe una convergencia incondicional
		- La velocidad anual de convergencia es del 1,67 por ciento anual.
		- El cincuenta por ciento de la brecha hacia el estado 	
		  estacionario se cerraría en 42 años.

*/


tw (sc ln_gdp_growth ln_gdp_60) (lfit ln_gdp_growth ln_gdp_60), ytitle("tasa de crecimiento vs log del producto por trabajador en 1960.") legend(off) name(model1, replace)

tw (sc ln_gdp_growth ln_gdp_60) (lfit ln_gdp_growth ln_gdp_60) if n==1, ytitle("tasa de crecimiento vs log del producto por trabajador en 1960.") legend(off) name(model1, replace)

tw (sc ln_gdp_growth ln_gdp_60) (lfit ln_gdp_growth ln_gdp_60) if i==1, ytitle("tasa de crecimiento vs log del producto por trabajador en 1960.") legend(off) name(model1, replace)

tw (sc ln_gdp_growth ln_gdp_60) (lfit ln_gdp_growth ln_gdp_60) if o==1, ytitle("tasa de crecimiento vs log del producto por trabajador en 1960.") legend(off) name(model1, replace)


	*******************************************
			******* P R E G U N T A 	ii (Conditional convergence)
	*******************************************
//
// quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if n==1, robust
// scalar speed_cc = - (log(1+_b[ln_gdp_60])/(1985-1960))
// quietly estadd scalar speed_cc
// scalar halfLife_cc = log(2)/speed_cc
// quietly estadd scalar halfLife_cc
// eststo cc_noil
//
// quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if i==1, robust
// scalar speed_cc = - (log(1+_b[ln_gdp_60])/(1985-1960))
// quietly estadd scalar speed_cc
// scalar halfLife_cc = log(2)/speed_cc
// quietly estadd scalar halfLife_cc
// eststo cc_int
//
// quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if o==1, robust
// scalar speed_cc = - (log(1+_b[ln_gdp_60])/(1985-1960))
// quietly estadd scalar speed_cc
// scalar halfLife_cc = log(2)/speed_cc
// quietly estadd scalar halfLife_cc
// eststo cc_oecd
//	
//
// * html
// esttab cc_noil cc_int cc_oecd, label se stats(r2 speed_cc halfLife_cc) title("Dependent variable: Growth GDP per worker 1960-1985") mtitle("Non-oil" "Intermediate" "OECD") html
//
//
// /*
// - Fuerte evidencia de convergencia condicional.
//
// - Mejora del ajuste de la regresión.
//
// */

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if n==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
quietly estadd scalar halfLife_augcc
eststo augcc_noil

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if i==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
quietly estadd scalar halfLife_augcc
eststo augcc_int

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if o==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
quietly estadd scalar halfLife_augcc
eststo augcc_oecd

// %html
esttab augcc_noil augcc_int augcc_oecd, label se stats(r2 speed_augcc halfLife_augcc) title("Dependent variable: Growth GDP per worker 1960-1985") mtitle("Non-oil" "Intermediate" "OECD") html
	
/*
- Agregar capital humano reduce aún más el coeficiente sobre el nivel inicial de ingresos. Es decir, acelera la velocidad de convergencia.

- Agregar capital humano mejora el ajuste.
*/	
	*******************************************
			******* P R E G U N T A 	iii
	*******************************************
	
quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school  c.ln_inv_gdp#c.ln_school if n==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
quietly estadd scalar halfLife_augcc
eststo augcc_noil

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school c.ln_inv_gdp#c.ln_school if i==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
quietly estadd scalar halfLife_augcc
eststo augcc_int

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school c.ln_inv_gdp#c.ln_school if o==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
quietly estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
quietly estadd scalar halfLife_augcc
eststo augcc_oecd	
	
	*******************************************
			******* P R E G U N T A 	iv
	*******************************************
quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school  c.ln_inv_gdp#c.ln_school if n==1, robust
imtest, white

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school c.ln_inv_gdp#c.ln_school if i==1, robust	
imtest, white

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school c.ln_inv_gdp#c.ln_school if o==1, robust
imtest, white

/*

La primera prueba de heterocedasticidad dada por imest es la prueba de White y la segunda dada por hettest es la prueba de Breusch-Pagan. Ambos prueban la hipótesis nula de que la varianza de los residuos es homogénea. Por tanto, si el valor p es muy pequeño, tendríamos que rechazar la hipótesis y aceptar la hipótesis alternativa de que la varianza no es homogénea. Entonces, en este caso, la evidencia está en contra de la hipótesis nula de que la varianza es homogénea. Estas pruebas son muy sensibles a los supuestos del modelo, como el supuesto de normalidad. Por lo tanto, es una práctica común combinar las pruebas con gráficos de diagnóstico para emitir un juicio sobre la gravedad de la heterocedasticidad y decidir si se necesita alguna corrección para la heterocedasticidad. En nuestro caso, el gráfico anterior no muestra una evidencia demasiado fuerte. Por lo tanto, no vamos a entrar en detalles sobre cómo corregir la heterocedasticidad a pesar de que existen métodos disponibles.
*/

	*******************************************
			******* P R E G U N T A 	v
	*******************************************
reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school  c.ln_inv_gdp#c.ln_school 
	avplot c.ln_inv_gdp#c.ln_school,mlabel(country)

/*
avplot grafica un gráfico de variables agregadas (también conocido como gráfico de apalancamiento de regresión parcial, regresión parcial
parcela o parcela residual parcial ajustada) después de la regresión. indepvar puede ser una variable independiente (también conocida como
predictor, portador o covariable) que se encuentra actualmente en el modelo o no.
*/

/*


Una de las características maravillosas de las regresiones de un regresor (regresiones de y sobre una x) es que puede graficar los datos y la línea de regresión. No hay forma más fácil de entender la regresión que para examinar tal gráfico. Desafortunadamente, no podemos hacer esto cuando tenemos más de un regresor. Con dos regresores, todavía es teóricamente posible: el gráfico debe dibujarse en tres dimensiones, pero con tres o más regresores no es posible graficar.
El gráfico de variables agregadas es un intento de proyectar datos multidimensionales de nuevo a los datos bidimensionales.
mundo para cada uno de los regresores originales. Esto es, por supuesto, imposible sin hacer algunos
concesiones. Llame a las coordenadas en una gráfica de variable agregada y y x. La gráfica de variable agregada tiene la
siguientes propiedades:
• Existe una correspondencia biunívoca entre (xi , yi) y la i-ésima observación utilizada en el original regresión
• Una regresión de y sobre x tiene el mismo coeficiente y error estándar (hasta un grado de libertad ajuste) como el coeficiente y el error estándar estimados para el regresor en la regresión original.
• El "valor atípico" de cada observación en la determinación de la pendiente se conserva en cierto sentido. Es igualmente importante tener en cuenta las propiedades que no se enumeran. Las coordenadas y y x de la
La gráfica de variables agregadas no se puede usar para identificar la forma funcional o, al menos, no bien (ver Mallows [1986]). En la construcción de la gráfica de variables agregadas, la relación entre y y x se ve obligada a
ser lineal
*/

	
	*******************************************
			******* P R E G U N T A 	SINTESIS
	*******************************************
