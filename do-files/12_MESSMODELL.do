log using "${logDirectory}12_Messmodell_Check.log", replace

//###############################################################

//************ Messmodell Check ************
//Schätzen des Messmodells alleine, um Kriterien für Güte des Modells zu  überprüfen (dafür sind Kovarianzen etc. notwendig)
//wird noch vor SEM full ausgewertet, da es notwendig für die Konstruktuion eines guten SEM ist
 

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

, 

latent (sexsatlat distract couple) 
standardized nocnsreport nocapslatent 
method(adf)  
cov()
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



log close
