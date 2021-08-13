//###############################################################

//************ Split Half Check ************

set seed 738
gen randomBinaryVar = .
replace randomBinaryVar = runiform(0,1) if includedInSem == 0
gen splitHalf = .
replace splitHalf = 0 if includedInSem == 0
sum randomBinaryVar, detail
replace splitHalf = 1 if randomBinaryVar > r(p50) & includedInSem == 0
drop randomBinaryVar

log using "${logDirectory}10_SEM_full_ML-SB_Split-Half_Gruppe1.log", replace

//######## Split Half Gruppe 1 - standardisiert ########

#delimit ;

sem
${gesamtModellPfade}
if splitHalf == 0
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## Split Half Gruppe 1 - unstandardisiert ########

#delimit ;

sem
${gesamtModellPfade}
if splitHalf == 0
, 
latent (sexsatlat distract couple) 
nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat residuals, standardized


log close


//-------------------- Gruppe 2 ------------------------

log using "${logDirectory}10_SEM_full_ML-SB_Split-Half_Gruppe2.log", replace

//######## Split Half Gruppe 2 - standardisiert ########

#delimit ;

sem
${gesamtModellPfade}
if splitHalf == 1
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)


//######## Split Half Gruppe 2 - unstandardisiert ########

#delimit ;

sem
${gesamtModellPfade}
if splitHalf == 1
, 
latent (sexsatlat distract couple) 
nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat residuals, standardized
	
log close
