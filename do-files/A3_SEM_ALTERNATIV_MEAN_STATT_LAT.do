log using "${logDirectory}A3_SEM_alternativ_Mean_statt_lat.log", replace

//######## SEM final ADF Unstandardisiert ########

#delimit ;

sem

	//Kernmodell
(sexquan -> sexsatMean)
(sexactBalance -> sexsatMean)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatMean)
(sexactBalance -> sexquan)		

	//Wissen über Vorlieben
(sexfan02 -> sexactBalance)
(sexfan02 -> sexquan)				
(sexpornB01 -> sexactBalance)
(sexpornB01 -> sexfan02)
(sexmastB01 -> sexfan02)

	//Kommunikation
(sexcomm01 -> sexactBalance)
(sexcomm01 -> distractMean)
(sexcomm01 -> sexsatMean)	

	//Externe
(distractMean -> sexorgasm01)
(distractMean -> sexactBalance)
(sexpornB01 -> distractMean)
(distractMean -> sexsatMean)

	//Beziehung
(coupleMean -> sexsatMean)
(coupleMean -> distractMean)
(coupleMean -> sexquan)

, 

latent () 
nocnsreport nocapslatent 
method(adf)  

cov(
sexmastB01*sexpornB01 
sexmastB01*coupleMean@0 
sexmastB01*sexcomm01@0 
sexpornB01*coupleMean@0 
sexpornB01*sexcomm01@0 
sexcomm01*coupleMean
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat teffects, standardized



//######## SEM final ADF standardisiert ########

#delimit ;

sem

	//Kernmodell
(sexquan -> sexsatMean)
(sexactBalance -> sexsatMean)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatMean)
(sexactBalance -> sexquan)		

	//Wissen über Vorlieben
(sexfan02 -> sexactBalance)
(sexfan02 -> sexquan)				
(sexpornB01 -> sexactBalance)
(sexpornB01 -> sexfan02)
(sexmastB01 -> sexfan02)

	//Kommunikation
(sexcomm01 -> sexactBalance)
(sexcomm01 -> distractMean)
(sexcomm01 -> sexsatMean)	

	//Externe
(distractMean -> sexorgasm01)
(distractMean -> sexactBalance)
(sexpornB01 -> distractMean)
(distractMean -> sexsatMean)

	//Beziehung
(coupleMean -> sexsatMean)
(coupleMean -> distractMean)
(coupleMean -> sexquan)

, 
latent () 
standardized nocnsreport nocapslatent 
method(adf)  
cov(
sexmastB01*sexpornB01 
sexmastB01*coupleMean@0 
sexmastB01*sexcomm01@0 
sexpornB01*coupleMean@0 
sexpornB01*sexcomm01@0 
sexcomm01*coupleMean
)
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)
estat teffects, standardized


log close
