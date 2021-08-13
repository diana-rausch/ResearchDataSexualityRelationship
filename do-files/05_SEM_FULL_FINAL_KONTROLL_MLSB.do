log using "${logDirectory}04_SEM_Kontroll_MLSB_standardized.log", replace

//######## SEM global Variable für Kontrollvariablenpfade #######

#delimit ;

global kontrollVariablenPfade = "

(age -> sexsatlat)
(age -> distract)
(age -> sexfan02)
(age -> sexactBalance)
(age -> sexquan)
(age -> sexorgasm01)

(education -> sexsatlat)
(education -> distract)
(education -> sexfan02)
(education -> sexactBalance)
(education -> sexquan)
(education -> sexorgasm01)

(stress01 -> sexsatlat)
(stress01 -> distract)
(stress01 -> sexfan02)
(stress01 -> sexactBalance)
(stress01 -> sexquan)
(stress01 -> sexorgasm01)			

(healthphys01 -> sexsatlat)
(healthphys01 -> distract)
(healthphys01 -> sexfan02)
(healthphys01 -> sexactBalance)
(healthphys01 -> sexquan)
(healthphys01 -> sexorgasm01)			

(bigfiveO -> sexsatlat)
(bigfiveO -> distract)
(bigfiveO -> sexfan02)
(bigfiveO -> sexactBalance)
(bigfiveO -> sexquan)
(bigfiveO -> sexorgasm01)

(coupleduration -> sexsatlat)
(coupleduration -> distract)
(coupleduration -> sexfan02)
(coupleduration -> sexactBalance)
(coupleduration -> sexquan)
(coupleduration -> sexorgasm01)

";

global kontrollVariablenKovarianzen = "

sexmastB01*sexpornB01 
sexmastB01*couple
sexmastB01*sexcomm01 
sexpornB01*couple
sexpornB01*sexcomm01 
sexcomm01*couple

age*couple
age*sexcomm01
age*sexmastB01
age*sexpornB01
education*couple
education*sexcomm01
education*sexmastB01
education*sexpornB01
stress01*couple
stress01*sexcomm01
stress01*sexmastB01
stress01*sexpornB01
healthphys01*couple
healthphys01*sexcomm01
healthphys01*sexmastB01
healthphys01*sexpornB01
bigfiveO*couple
bigfiveO*sexcomm01
bigfiveO*sexmastB01
bigfiveO*sexpornB01
coupleduration*couple
coupleduration*sexcomm01
coupleduration*sexmastB01
coupleduration*sexpornB01

age*education
age*stress01
age*healthphys01
age*bigfiveO
age*coupleduration

education*stress01
education*healthphys01
education*bigfiveO
education*coupleduration

stress01*healthphys01
stress01*bigfiveO
stress01*coupleduration

healthphys01*bigfiveO
healthphys01*coupleduration

bigfiveO*coupleduration

";

#delimit cr

//######## SEM final MLSB standardisiert ########
//mit Kontrollvariablen
//alle Kovarianzen frei

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
cov(
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
	
log close

//------------------------------------------------------------
	
log using "${logDirectory}04_SEM_KONTROLL_MLSB_teffects.log", replace
	
estat teffects, standardized

log close



//------------------------------------------------------------


log using "${logDirectory}04_SEM_Kontroll_MLSB_unstandardized.log", replace


//######## SEM final MLSB unstandardisiert ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
, 
latent (sexsatlat distract couple) 
nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${kontrollVariablenKovarianzen}
)
;																							

#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat residuals, standardized
estat residuals

log close
