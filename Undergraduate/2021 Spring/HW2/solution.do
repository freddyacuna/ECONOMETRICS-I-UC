* Clean you environment
clear all
macro drop _all
set more off
cls
version 12

* Install modules
*ssc install estout
*ssc install outreg2


* Describe and summarize dataset
use "https://github.com/quarcs-lab/data-quarcs/raw/master/mrw1992/mrw2.dta", clear

describe
summarize

* Create variables
gen delta_gamma = 0.05
gen ln_gdp_60 = ln(rgdpw60)
gen ln_gdp_85 = ln(rgdpw85)
gen ln_gdp_growth =  ln(rgdpw85) - ln(rgdpw60)
gen ln_inv_gdp = ln(i_y/100)
gen ln_ndg = ln(popgrowth/100 + delta_gamma)
gen ln_school = ln(school)

summarize

* Add labels to varaibles (Understand the meaning and construction of each variable)

label variable rgdpw60 "Real GDP per worker in 1960"
label variable rgdpw85 "Real GDP per worker in 1985"
label variable gdpgrowth "Growth rate GDP per woker 1960-1985"
label variable popgrowth "Average growth rate of the working-age population (working age 15-64)"
label variable i_y "Average share of GDP of real investment (includes gov. investment)"
label variable school "Percentage of the working-age population that is in secondary school."

label variable n "non-oil producting countries"
label variable i "intermediate quality data countries"
label variable o "OECD countries"

label variable delta_gamma "Depreciation rate + Technological growth rate"
label variable ln_gdp_60 "Log GDP per woker in 1960"
label variable ln_gdp_85 "Log GDP per woker in 1985"
label variable ln_gdp_growth "Growth GDP per woker 1960-1985 (as log difference)"
label variable ln_inv_gdp "Log investment share"
label variable ln_ndg "Log (adjusted) population growth"
label variable ln_school "Log human capital"

describe

* Steady-state production function: Unrestricted Solow model
quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if n==1, robust
eststo solow_noil

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if i==1, robust
eststo solow_int

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg if o==1, robust
eststo solow_oecd

esttab solow_noil solow_int solow_oecd, r2 se scalar(rmse) title("Dependent variable: Ln GDP pc in 1985") mtitle("Non-oil" "Intermediate" "OECD")

* Steady-state production function: Unrestricted augmented Solow model
quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if n==1, robust
eststo augsolow_noil

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if i==1, robust
eststo augsolow_int

quietly reg ln_gdp_85 ln_inv_gdp ln_ndg ln_school if o==1, robust
eststo augsolow_oecd

esttab augsolow_noil augsolow_int augsolow_oecd, r2 se scalar(rmse) title("Dependent variable: Ln GDP pc in 1985") mtitle("Non-oil" "Intermediate" "OECD")


* Transitioning to steady state: Unconditional (beta) convergence in the Solow model
eststo clear

quietly reg ln_gdp_growth ln_gdp_60 if n==1, robust
scalar speed_ucc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_ucc
scalar halfLife_ucc = log(2)/speed_ucc
estadd scalar halfLife_ucc
eststo ucc_noil

quietly reg ln_gdp_growth ln_gdp_60 if i==1, robust
scalar speed_ucc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_ucc
scalar halfLife_ucc = log(2)/speed_ucc
estadd scalar halfLife_ucc
eststo ucc_int

quietly reg ln_gdp_growth ln_gdp_60 if o==1, robust
scalar speed_ucc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_ucc
scalar halfLife_ucc = log(2)/speed_ucc
estadd scalar halfLife_ucc
eststo ucc_oecd

esttab ucc_noil ucc_int ucc_oecd, se stats(r2 speed_ucc halfLife_ucc) title("Dependent variable: Growth GDP pc 1960-1985") mtitle("Non-oil" "Intermediate" "OECD")

eststo clear



* Transitioning to steady state: Conditional (beta) convergence in the  Solow model
eststo clear

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if n==1, robust
scalar speed_cc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_cc
scalar halfLife_cc = log(2)/speed_cc
estadd scalar halfLife_cc
eststo cc_noil

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if i==1, robust
scalar speed_cc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_cc
scalar halfLife_cc = log(2)/speed_cc
estadd scalar halfLife_cc
eststo cc_int

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if o==1, robust
scalar speed_cc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_cc
scalar halfLife_cc = log(2)/speed_cc
estadd scalar halfLife_cc
eststo cc_oecd

esttab cc_noil cc_int cc_oecd, se stats(r2 speed_cc halfLife_cc) title("Dependent variable: Growth GDP pc 1960-1985") mtitle("Non-oil" "Intermediate" "OECD")

eststo clear

* Transitioning to steady state: Conditional (beta) convergence in the augmented Solow model
eststo clear

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if n==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
estadd scalar halfLife_augcc
eststo augcc_noil

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if i==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
estadd scalar halfLife_augcc
eststo augcc_int

quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if o==1, robust
scalar speed_augcc = - (log(1+_b[ln_gdp_60])/(1985-1960))
estadd scalar speed_augcc
scalar halfLife_augcc = log(2)/speed_augcc
estadd scalar halfLife_augcc
eststo augcc_oecd

esttab augcc_noil augcc_int augcc_oecd, se stats(r2 speed_augcc halfLife_augcc) title("Dependent variable: Growth GDP pc 1960-1985") mtitle("Non-oil" "Intermediate" "OECD")

eststo clear

*---------------------------------------------------------------------------
* Classical beta convergence analysis (example for intermediate countries)
*---------------------------------------------------------------------------

eststo clear

* Model 1: Unconditional convergence
quietly reg ln_gdp_growth ln_gdp_60 if i==1, robust
scalar speed = - (log(1+_b[ln_gdp_60])/(1985-1960))
  estadd scalar speed
scalar halfLife = log(2)/speed
  estadd scalar halfLife
eststo model1

* Model 2: Conditional convergence based on investment share
quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp  if i==1, robust
scalar speed = - (log(1+_b[ln_gdp_60])/(1985-1960))
  estadd scalar speed
scalar halfLife = log(2)/speed
  estadd scalar halfLife
eststo model2

* Model 3: Conditional convergence based on investment share and adjusted population
quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg if i==1, robust
scalar speed = - (log(1+_b[ln_gdp_60])/(1985-1960))
  estadd scalar speed
scalar halfLife = log(2)/speed
  estadd scalar halfLife
eststo model3

* Model 4: Conditional convergence based on investment share, adjusted population, and human capital
quietly reg ln_gdp_growth ln_gdp_60 ln_inv_gdp ln_ndg ln_school if i==1, robust
scalar speed = - (log(1+_b[ln_gdp_60])/(1985-1960))
  estadd scalar speed
scalar halfLife = log(2)/speed
  estadd scalar halfLife
eststo model4

* Show all models in a comparative table
esttab model1 model2 model3 model4, se stats(r2 speed halfLife) title("Dependent variable: Growth GDP pc 1960-1985 of intermediate countries") mtitle("Model" "Model" "Model" "Model")

eststo clear


*---------------------------------------------------------------------------
* Plots of classical beta convergence analysis (example for intermediate countries)
*---------------------------------------------------------------------------

* For nicer figures, install and activate the following
*net install gr0070, from(http://www.stata-journal.com/software/sj17-3)
*set scheme plotplainblind

* Model 1: Unconditional convergence
quietly reg ln_gdp_growth  if i==1
predict growth_model1_residuals, residuals

tw (sc growth_model1_residuals ln_gdp_60) (lfit growth_model1_residuals ln_gdp_60) if i==1, ytitle("Growth GDP per worker (1960-1985)") legend(off) name(model1, replace)

* Model 2: Conditional convergence based on investment share
quietly reg ln_gdp_growth ln_inv_gdp  if i==1
predict growth_model2_residuals, residuals

tw (sc growth_model2_residuals ln_gdp_60) (lfit growth_model2_residuals ln_gdp_60) if i==1, ytitle("Conditional growth GDP per worker (1960-1985)") legend(off) name(model2, replace)

* Model 3: Conditional convergence based on investment share and adjusted population
quietly reg ln_gdp_growth ln_inv_gdp ln_ndg  if i==1
predict growth_model3_residuals, residuals

tw (sc growth_model3_residuals ln_gdp_60) (lfit growth_model3_residuals ln_gdp_60) if i==1, ytitle("Conditional growth GDP per worker (1960-1985)") legend(off) name(model3, replace)


* Model 4: Conditional convergence based on investment share, adjusted population, and human capital
quietly reg ln_gdp_growth ln_inv_gdp ln_ndg ln_school  if i==1
predict growth_model4_residuals, residuals

tw (sc growth_model4_residuals ln_gdp_60) (lfit growth_model4_residuals ln_gdp_60) if i==1, ytitle("Conditional growth GDP per worker (1960-1985)") legend(off) name(model4, replace)
