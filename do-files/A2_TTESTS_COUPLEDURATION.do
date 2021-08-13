log using "${logDirectory}A2_Anova_Coupleduration.log", replace

//######## T-Tests zur Überprüfung auf Mittelwertunterschiede zwischen kurzer und langer Beziehungsdauer ########

foreach var of varlist sexsat01 sexsat02 sexsat03 sexactBalance sexorgasm01 sexquan sexmastB01 sexpornB01 sexfan02 sexcomm01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 age education stress01 healthphys01 bigfiveO coupleduration{			//schaut sich alle Variablen des Datensatzes an
   quietly ttest `var' if coupledurationCat!=1, by(coupledurationCat)
   display "`var';" r(p) ";" r(t) ";"  r(mu_1) ";"  r(mu_2)
   quietly esize twosample `var' if coupledurationCat!=1, by(coupledurationCat)
   display ";" r(d) ";" r(lb_d) ";" r(ub_d)
}

log close
