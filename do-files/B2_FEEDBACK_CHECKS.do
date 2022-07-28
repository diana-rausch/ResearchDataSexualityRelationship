recode hhsize_c (.m = 0)(1/max = 1), gen(kids)
recode religion (1=0)(2/max = 1), gen(religious)
recode coupletype (2 = 0) (3/max = 1), gen(nonmonogamy)
recode sexpornB01 (1/3 = 0)(5/7 = 1), gen(consumesporn)

//######## SEM global Variable für kontrollVariablenPfade #######

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

global kontrollVariablenPfadePlus = "

(healthment -> sexsatlat)
(healthment -> distract)
(healthment -> sexfan02)
(healthment -> sexactBalance)
(healthment -> sexquan)
(healthment -> sexorgasm01)

(kids -> sexsatlat)
(kids -> distract)
(kids -> sexfan02)
(kids -> sexactBalance)
(kids -> sexquan)
(kids -> sexorgasm01)

(religious -> sexsatlat)
(religious -> distract)
(religious -> sexfan02)
(religious -> sexactBalance)
(religious -> sexquan)
(religious -> sexorgasm01)

(nonmonogamy -> sexsatlat)
(nonmonogamy -> distract)
(nonmonogamy -> sexfan02)
(nonmonogamy -> sexactBalance)
(nonmonogamy -> sexquan)
(nonmonogamy -> sexorgasm01)

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

global kontrollVariablenKovarianzenPlus = "

healthment*couple
healthment*sexcomm01
healthment*sexmastB01
healthment*sexpornB01
kids*couple
kids*sexcomm01
kids*sexmastB01
kids*sexpornB01
religious*couple
religious*sexcomm01
religious*sexmastB01
religious*sexpornB01
nonmonogamy*couple
nonmonogamy*sexcomm01
nonmonogamy*sexmastB01
nonmonogamy*sexpornB01

education*healthment
education*kids
education*religious
education*nonmonogamy

stress01*healthment
stress01*kids
stress01*religious
stress01*nonmonogamy

age*healthment
age*kids
age*religious
age*nonmonogamy

healthphys01*healthment
healthphys01*kids
healthphys01*religious
healthphys01*nonmonogamy

bigfiveO*healthment
bigfiveO*kids
bigfiveO*religious
bigfiveO*nonmonogamy

coupleduration*healthment
coupleduration*kids
coupleduration*religious
coupleduration*nonmonogamy

healthment*kids
healthment*religious
healthment*nonmonogamy

kids*religious
kids*nonmonogamy

religious*nonmonogamy

";

#delimit cr


log using "${logDirectory}B2_SEM_full_MLSB_standardized_partner-mono.log", replace

//######## SEM final MLSB standardisiert nur ein Partner ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
coupletype == 2
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_partner-multi.log", replace

//######## SEM final MLSB standardisiert mehrere Partner/offene Beziehung ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
coupletype > 2
,
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)   
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------


log using "${logDirectory}B2_SEM_full_MLSB_standardized_kids-no.log", replace

//######## SEM final MLSB standardisiert keine Kinder ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
kids == 0
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)   
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_kids-yes.log", replace

//######## SEM final MLSB standardisiert mit Kindern ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
kids == 1
,
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------


log using "${logDirectory}B2_SEM_full_MLSB_standardized_openness-yes.log", replace

//######## SEM final MLSB standardisiert offen ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
bigfiveO > 4
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)   
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_openness-no.log", replace

//######## SEM final MLSB standardisiert nicht offen ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
bigfiveO < 4
,
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------


log using "${logDirectory}B2_SEM_full_MLSB_standardized_religion-no.log", replace

//######## SEM final MLSB standardisiert offen ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
religious == 0
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)   
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_religion-yes.log", replace

//######## SEM final MLSB standardisiert nicht offen ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
religious == 1
,
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_porn-no.log", replace

//######## SEM final MLSB standardisiert keine Pornos ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
consumesporn == 0
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_porn-yes.log", replace

//######## SEM final MLSB standardisiert Pornos ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
consumesporn == 1
,
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)   
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_healthment-yes.log", replace

//######## SEM final MLSB standardisiert keine Pornos ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
healthment > 4
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_healthment-no.log", replace

//######## SEM final MLSB standardisiert Pornos ########

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if
healthment < 4
,
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)   
cov(
${gesamtModellKovarianzen}
${kontrollVariablenKovarianzen}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_KONTROLL-PLUS.log", replace

//------------------------------------------------------------
//######## SEM final ADF standardisiert ########
//mit Kontrollvariablen
//alle Kovarianzen frei

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
${kontrollVariablenPfadePlus}
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${kontrollVariablenKovarianzen}
${kontrollVariablenKovarianzenPlus}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
	
log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_KONTROLL-PLUS-SHORTREL.log", replace

//------------------------------------------------------------
//######## SEM final ADF standardisiert ########
//mit Kontrollvariablen
//alle Kovarianzen frei
//kurze Bezdau

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
${kontrollVariablenPfadePlus}
if coupledurationCat == 1
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${kontrollVariablenKovarianzen}
${kontrollVariablenKovarianzenPlus}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
	
log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_KONTROLL-PLUS-MEDIUMREL.log", replace

//------------------------------------------------------------
//######## SEM final ADF standardisiert ########
//mit Kontrollvariablen
//alle Kovarianzen frei
//mittle Bezdau

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
${kontrollVariablenPfadePlus}
if coupledurationCat == 2
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${kontrollVariablenKovarianzen}
${kontrollVariablenKovarianzenPlus}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
	
log close

//------------------------------------------------------------

log using "${logDirectory}B2_SEM_full_MLSB_standardized_KONTROLL-PLUS-LONGREL.log", replace

//------------------------------------------------------------
//######## SEM final ADF standardisiert ########
//mit Kontrollvariablen
//alle Kovarianzen frei
//lange Bezdau

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
${kontrollVariablenPfadePlus}
if coupledurationCat == 3
, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
cov(
${kontrollVariablenKovarianzen}
${kontrollVariablenKovarianzenPlus}
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
	
log close

//------------------------------------------------------------
