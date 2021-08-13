log using "${logDirectory}A4_ALTERNATE_MODELS.log", replace


//######## SEM Alternativmodell Pornografie ########

#delimit ;

sem
${gesamtModellPfade}
(sexpornB01 -> sexsatlat)
(sexpornB01 -> sexquan)
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



//######## SEM Alternativmodell Pornografie inkl. Rückpfeil ########

#delimit ;

sem
${gesamtModellPfade}
(sexpornB01 -> sexsatlat)
(sexsatlat -> sexpornB01)
(sexpornB01 -> sexquan)
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(adf)  
cov(
sexmastB01*couple@0 
sexmastB01*sexcomm01@0 
sexcomm01*couple
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM Alternativmodell Masturbation ########

#delimit ;

sem
${gesamtModellPfade}
(sexmastB01 -> sexsatlat)
(sexmastB01 -> sexquan)
(sexmastB01 -> sexorgasm01)
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



//######## SEM Alternativmodell Masturbation inkl. Rückpfeil ########

#delimit ;

sem
${gesamtModellPfade}
(sexmastB01 -> sexsatlat)
(sexsatlat -> sexmastB01)
(sexmastB01 -> sexquan)
(sexmastB01 -> sexorgasm01)
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(adf)  
cov(
sexpornB01*couple@0 
sexpornB01*sexcomm01@0 
sexcomm01*couple
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM Alternativmodell Ablenkung auf Häufigkeit ########

#delimit ;

sem
${gesamtModellPfade}
(distract -> sexquan)
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



//######## SEM Alternativmodell Zufriedenheit zurück auf Häufigkeit ########

#delimit ;

sem
${gesamtModellPfade}
(sexsatlat -> sexquan)
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



//######## SEM Alternativmodell Zufriedenheit zurück auf Partnerschaft ########

#delimit ;

sem
${gesamtModellPfade}
(sexsatlat -> couple)
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(adf)  
cov(
sexmastB01*sexpornB01  
sexmastB01*sexcomm01@0 
sexpornB01*sexcomm01@0 
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)


log close
