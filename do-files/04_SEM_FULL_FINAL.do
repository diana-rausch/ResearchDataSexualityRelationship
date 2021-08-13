log using "${logDirectory}04_SEM_full_ADF_standardized.log", replace


//######## SEM global Variable für Gesamtmodellpfade #######

#delimit ;

global gesamtModellPfade = "

(sexsatlat -> sexsat01)
(sexsatlat -> sexsat02)
(sexsatlat -> sexsat03)

(couple -> couplebond01)
(couple -> couplebond02)
(couple -> coupleint01)

(distract -> sexnet01)				
(distract -> sexnet02)	

(sexquan -> sexsatlat)
(sexactBalance -> sexsatlat)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatlat)
(sexactBalance -> sexquan)		

(sexfan02 -> sexactBalance)
(sexfan02 -> sexquan)				
(sexpornB01 -> sexactBalance)
(sexpornB01 -> sexfan02)
(sexmastB01 -> sexfan02)

(sexcomm01 -> sexactBalance)
(sexcomm01 -> distract)
(sexcomm01 -> sexsatlat)	

(distract -> sexorgasm01)
(distract -> sexactBalance)
(sexpornB01 -> distract)
(distract -> sexsatlat)

(couple -> sexsatlat)
(couple -> distract)
(couple -> sexquan)

";

global gesamtModellKovarianzen = "

sexmastB01*sexpornB01 
sexmastB01*couple@0 
sexmastB01*sexcomm01@0 
sexpornB01*couple@0 
sexpornB01*sexcomm01@0 
sexcomm01*couple

";

#delimit cr



//######## SEM final ADF standardisiert ########

#delimit ;

sem
${gesamtModellPfade}
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(adf)  
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

//-----Berechnung der Signifikanz bestimmter indirekter Effekte-----
nlcom _b[sexsatlat:sexquan]*_b[sexquan:sexactBalance]
nlcom _b[sexsatlat:sexorgasm01]*_b[sexorgasm01:sexactBalance]
nlcom _b[sexsatlat:distract]*_b[distract:couple]
nlcom _b[sexsatlat:sexquan]*_b[sexquan:couple]
nlcom _b[sexsatlat:sexactBalance]*_b[sexactBalance:distract]
nlcom _b[sexsatlat:sexorgasm01]*_b[sexorgasm01:distract]
nlcom _b[sexsatlat:distract]*_b[distract:sexcomm01]
nlcom _b[sexsatlat:sexactBalance]*_b[sexactBalance:sexcomm01]
nlcom _b[sexsatlat:sexactBalance]*_b[sexactBalance:sexfan02]
nlcom _b[sexsatlat:sexquan]*_b[sexquan:sexfan02]

//######## Schätzen der Ausprägung der latenten Variablen anhand des Modells //########

predict sexsatlatModelpred, xblatent(sexsatlat)
sum sexsatlatModelpred, detail

predict distractModelpred, xblatent(distract)
sum distractModelpred, detail

predict sexsatlatMeasurementPred, latent(sexsatlat)
sum sexsatlatMeasurementPred, detail

predict coupleMeasurementPred, latent(couple)
sum coupleMeasurementPred, detail

predict distractMeasurementPred, latent(distract)
sum distractMeasurementPred, detail


	
log close

//------------------------------------------------------------
	
log using "${logDirectory}04_SEM_full_ADF_teffects.log", replace
	
estat teffects, standardized

log close



//------------------------------------------------------------


log using "${logDirectory}04_SEM_full_ADF_unstandardized.log", replace


//######## SEM final ADF unstandardisiert ########

#delimit ;

sem
${gesamtModellPfade}
, 
latent (sexsatlat distract couple) 
nocnsreport nocapslatent 
method(adf)  
cov(
${gesamtModellKovarianzen}
)
;																							

#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat residuals, standardized
estat residuals
		
log close




//------------------------------------------------------------


log using "${logDirectory}04_SEM_full_ML-SB_standardized.log", replace

//######## SEM final ML SBentler standardisiert ########


#delimit ;

sem
${gesamtModellPfade}
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

log close




//------------------------------------------------------------


log using "${logDirectory}04_SEM_full_ML-SB_unstandardized.log", replace


//######## SEM final ML SBentler unstandardisiert ########

#delimit ;

sem
${gesamtModellPfade}
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

//------------------------------------------------------------


log using "${logDirectory}04_SEM_full_ML_standardized.log", replace

//######## SEM final ML standardisiert ########


#delimit ;

sem
${gesamtModellPfade}
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)  
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----

estat gof, stats(all)

log close




//------------------------------------------------------------


log using "${logDirectory}04_SEM_full_ML_unstandardized.log", replace


//######## SEM final ML SBentler unstandardisiert ########

#delimit ;

sem
${gesamtModellPfade}
,
latent (sexsatlat distract couple) 
nocnsreport nocapslatent 
method(ml) 
cov(
${gesamtModellKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat residuals, standardized
	
log close
