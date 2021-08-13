log using "${logDirectory}09_Missing_Check.log", replace

//###############################################################

//************ Missing Check ************
// Test auf systematische Verzerrung der Stichprobe

egen includedInSem = rowmiss(sexsat01 sexsat02 sexsat03 sexactBalance sexorgasm01 sexquan sexmastB01 sexpornB01 sexfan02 sexcomm01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01)
replace includedInSem = 1 if includedInSem > 0

tab includedInSem

display "variable;p.value;t.value;sample.average;sample.sd;missing.average;missing.sd;d;d-lb;d-ub"  
foreach var of varlist sexsat01 sexsat02 sexsat03 sexquan sexorgasm01 sexactBalance sexfan02 sexmastB01 sexpornB01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexcomm01 coupleduration bigfiveO stress01 healthphys01 age education {			//schaut sich alle Variablen des Datensatzes an
   quietly ttest `var', by(includedInSem)
   display "`var';" r(p) ";" r(t) ";"  r(mu_1) ";" r(sd_1) ";" r(mu_2) ";" r(sd_2)
   quietly esize twosample `var', by(includedInSem)
   display ";" r(d) ";" r(lb_d) ";" r(ub_d)
}
log close
