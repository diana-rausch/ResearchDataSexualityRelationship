log using "${logDirectory}06_SEM_Gruppe_Beziehungslänge_Beschreibung.log", replace


//######### Gruppen Beschreibung #################

sum sexsat01 sexsat02 sexsat03 sexquan sexorgasm01 sexactBalance sexfan sexmastB01 sexpornB01 sexcomm01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 coupleduration if coupledurationCat == 1
sum sexsat01 sexsat02 sexsat03 sexquan sexorgasm01 sexactBalance sexfan sexmastB01 sexpornB01 sexcomm01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 coupleduration if coupledurationCat == 2
sum sexsat01 sexsat02 sexsat03 sexquan sexorgasm01 sexactBalance sexfan sexmastB01 sexpornB01 sexcomm01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 coupleduration if coupledurationCat == 3


sum age education stress01 healthphys01 bigfiveO coupleduration if coupledurationCat == 1
sum age education stress01 healthphys01 bigfiveO coupleduration if coupledurationCat == 2
sum age education stress01 healthphys01 bigfiveO coupleduration if coupledurationCat == 3


log close



log using "${logDirectory}06_SEM_Gruppe_Beziehungslänge_ML-SB_standardisiert.log", replace


//------------ Modelle für einzelne Gruppen rechnen, standardisiert --------

//************ Modell Stufe 5 - komplettes Modell Gruppe 1 ************
//ML
//SBentler
//standardisiert

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if coupledurationCat == 1
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
estat teffects, standardized



//************ Modell Stufe 5 - komplettes Modell Gruppe 2 ************
//ML
//SBentler
//standardisiert

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if coupledurationCat == 2
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
estat teffects, standardized



//************ Modell Stufe 5 - komplettes Modell Gruppe 3 ************
//ML
//SBentler
//standardisiert

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if coupledurationCat == 3
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
estat teffects, standardized

log close



log using "${logDirectory}06_SEM_Gruppe_Beziehungslänge_ML-SB_unstandardisiert.log", replace


//------------ Modelle für einzelne Gruppen rechnen, unstandardisiert --------

//************ Modell Stufe 5 - komplettes Modell Gruppe 1 ************
//ML
//SBentler
//unstandardisiert

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if coupledurationCat == 1
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
estat teffects, standardized



//************ Modell Stufe 5 - komplettes Modell Gruppe 2 ************
//ML
//SBentler
//unstandardisiert


#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if coupledurationCat == 2
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
estat teffects, standardized



//************ Modell Stufe 5 - komplettes Modell Gruppe 3 ************
//ML
//SBentler
//unstandardisiert

#delimit ;

sem
${gesamtModellPfade}
${kontrollVariablenPfade}
if coupledurationCat == 3
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
estat teffects, standardized



log close
