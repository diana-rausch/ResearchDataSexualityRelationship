log using "${logDirectory}07_Varianz_erklärt_durch_Variablengruppen_ohne_Kontrollvar.log", replace

//Erklärte Varianz der einzelnen Variablengruppen
//ohne Kontrollvar

//###############################################################

//************ Gesamtmodell ohne Bewusstsein Vorlieben ************

#delimit ;

sem

	//Messmodell Zufriedenheit
(sexsatlat -> sexsat01)
(sexsatlat -> sexsat02)
(sexsatlat -> sexsat03)

	//Messmodell Beziehung
(couple -> couplebond01)
(couple -> couplebond02)
(couple -> coupleint01)

	//Messmodell ablenkende Gedanken
(distract -> sexnet01)				
(distract -> sexnet02)	

	//Kernmodell
(sexquan -> sexsatlat)
(sexactBalance -> sexsatlat)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatlat)
(sexactBalance -> sexquan)		

	//Kommunikation
(sexcomm01 -> sexactBalance)
(sexcomm01 -> distract)
(sexcomm01 -> sexsatlat)	

	//Externe
(distract -> sexorgasm01)
(distract -> sexactBalance)
(sexpornB01 -> distract)
(distract -> sexsatlat)

	//Beziehung
(couple -> sexsatlat)
(couple -> distract)
(couple -> sexquan)

, 
latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(adf)  

cov(
sexcomm01*couple
)		
;

#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//************ Gesamtmodell ohne Ablenkung ************

#delimit ;

sem

	//Messmodell Zufriedenheit
(sexsatlat -> sexsat01)
(sexsatlat -> sexsat02)
(sexsatlat -> sexsat03)

	//Messmodell Beziehung
(couple -> couplebond01)
(couple -> couplebond02)
(couple -> coupleint01)

	//Kernmodell
(sexquan -> sexsatlat)
(sexactBalance -> sexsatlat)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatlat)
(sexactBalance -> sexquan)		

	//Wissen über Vorlieben
(sexfan02 -> sexactBalance)
(sexfan02 -> sexquan)				
(sexpornB01 -> sexactBalance)
(sexpornB01 -> sexfan02)
(sexmastB01 -> sexfan02)

	//Kommunikation
(sexcomm01 -> sexactBalance)
(sexcomm01 -> sexsatlat)	

	//Beziehung
(couple -> sexsatlat)
(couple -> sexquan)

, 
latent (sexsatlat couple) 
standardized nocnsreport nocapslatent 
method(adf)  

cov(
sexmastB01*sexpornB01 
sexmastB01*couple@0 
sexmastB01*sexcomm01@0 
sexpornB01*couple@0 
sexpornB01*sexcomm01@0 
sexcomm01*couple
)		
;

#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//************ Gesamtmodell ohne Partnerschaft und Kommunikation ************

#delimit ;

sem

	//Messmodell Zufriedenheit
(sexsatlat -> sexsat01)
(sexsatlat -> sexsat02)
(sexsatlat -> sexsat03)

	//Messmodell ablenkende Gedanken
(distract -> sexnet01)				
(distract -> sexnet02)	

	//Kernmodell
(sexquan -> sexsatlat)
(sexactBalance -> sexsatlat)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatlat)
(sexactBalance -> sexquan)		

	//Wissen über Vorlieben
(sexfan02 -> sexactBalance)
(sexfan02 -> sexquan)				
(sexpornB01 -> sexactBalance)
(sexpornB01 -> sexfan02)
(sexmastB01 -> sexfan02)	

	//Externe
(distract -> sexorgasm01)
(distract -> sexactBalance)
(sexpornB01 -> distract)
(distract -> sexsatlat)

, 
latent (sexsatlat distract) 
standardized nocnsreport nocapslatent 
method(adf)  

cov(
sexmastB01*sexpornB01 
)		
;

#delimit cr

//-----Testen der Modellgüte-----

estat gof, stats(all)



//************ Gesamtmodell ohne Ausgestaltung ************

#delimit ;

sem

(sexsatlat -> sexsat01)
(sexsatlat -> sexsat02)
(sexsatlat -> sexsat03)

(couple -> couplebond01)
(couple -> couplebond02)
(couple -> coupleint01)

(distract -> sexnet01)				
(distract -> sexnet02)		

(sexfan02 -> sexsatlat)			
(sexpornB01 -> sexsatlat)
(sexmastB01 -> sexfan02)

(sexcomm01 -> distract)
(sexcomm01 -> sexsatlat)	

(sexpornB01 -> distract)
(distract -> sexsatlat)

(couple -> sexsatlat)
(couple -> distract)

, 
latent (sexsatlat couple distract) 
standardized nocnsreport nocapslatent 
method(adf)  

cov(
sexmastB01*sexpornB01 
sexmastB01*couple@0 
sexmastB01*sexcomm01@0 
sexpornB01*couple@0 
sexpornB01*sexcomm01@0 
sexcomm01*couple
)		
;

#delimit cr

//-----Testen der Modellgüte-----

estat gof, stats(all)



//************ Grundmodell ************

#delimit ;

sem

	//Messmodell Zufriedenheit
(sexsatlat -> sexsat01)
(sexsatlat -> sexsat02)
(sexsatlat -> sexsat03)

	//Kernmodell
(sexquan -> sexsatlat)
(sexactBalance -> sexsatlat)		
(sexactBalance -> sexorgasm01)
(sexorgasm01 -> sexsatlat)
(sexactBalance -> sexquan)			

, 
latent (sexsatlat) 
standardized nocnsreport nocapslatent 
method(adf)  
	
;

#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)


log close
