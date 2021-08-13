log using "${logDirectory}13_Baseline_CFI-TLI.log", replace


//######## SEM final ADF standardisiert - CFI TLI standard Baseline ########
//Modell ohne Kontrollvariablen

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

,
latent () 
standardized nocnsreport nocapslatent 
method(adf)  
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM final ADF standardisiert - CFI TLI standard Baseline ########
//Modell MIT Kontrollvariablen

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

(age)
(education)
(stress01)
(healthphys01)
(bigfiveO)
(coupleduration)

, 
latent () 
standardized nocnsreport nocapslatent 
method(adf)  
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)




//######## SEM Kernmodell ADF standardisiert - CFI TLI standard Baseline ########
//Kernmodell

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(sexquan)
(sexactBalance)		
(sexorgasm01)

, 
latent () 
standardized nocnsreport nocapslatent 
method(adf)  
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)


//######## SEM final ML SB standardisiert - CFI TLI standard Baseline ########
//Modell ohne Kontrollvariablen
//ML SB

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

, 
latent () 
standardized nocnsreport nocapslatent 
method(ml)
vce(sbentler)  
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM final ML OHNE SB standardisiert - CFI TLI standard Baseline ########
//Modell ohne Kontrollvariablen
//ML


#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

, 

latent () 
standardized nocnsreport nocapslatent 
method(ml)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)


//######## SEM Modell Alternative mit Mittelwerten - CFI TLI standard Baseline ADF ########
//Modell ohne Kontrollvariablen
//Mean statt Lat

#delimit ;

sem

(sexsatMean)
(coupleMean)
(distractMean)				

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

, 
latent () 
standardized nocnsreport nocapslatent 
method(adf)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM final ML SB standardisiert Gruppenvergleich - CFI TLI standard Baseline ########
//Modell MIT Kontrollvariablen
//Gruppe 2

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

(age)
(education)
(stress01)
(healthphys01)
(bigfiveO)
(coupleduration)

if coupledurationCat == 1
, 
latent () 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)


//######## SEM final ML SB standardisiert Gruppenvergleich - CFI TLI standard Baseline ########
//Modell MIT Kontrollvariablen
//Gruppe 3

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

(age)
(education)
(stress01)
(healthphys01)
(bigfiveO)
(coupleduration)

if coupledurationCat == 2
, 
latent () 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM final ML SB standardisiert Gruppenvergleich - CFI TLI standard Baseline ########
//Modell MIT Kontrollvariablen
//Gruppe 3

#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

(age)
(education)
(stress01)
(healthphys01)
(bigfiveO)
(coupleduration)

if coupledurationCat == 3
, 
latent () 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//-----------------------------------------------------

//Pornomodelle

//######## SEM final Modell Alternative mit Porno auf Häufigkeit und Zufriedenheit ########
//######## SEM final Modell Alternative mit Porno auf Häufigkeit und Zufriedenheit  - rekursiv ########
//Modell OHNE Kontrollvariablen
//Baselinemodell entspricht normalem Baseline-Modell, da keine zusätzlichen variablen eingeführt werden und auch keine anderen Schätzer benutzt werden


#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

, 
latent () 
standardized nocnsreport nocapslatent 
method(adf)  
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//-----------------------------------------------------

//Split Half

//######## SEM final Modell Split Half 1 ########


#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

if splitHalf == 0

, 
latent () 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0
;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)



//######## SEM final Modell Split Half 2 ########


#delimit ;

sem

(sexsat01)
(sexsat02)
(sexsat03)

(couplebond01)
(couplebond02)
(coupleint01)

(sexnet01)				
(sexnet02)	

(sexquan)
(sexactBalance)		
(sexorgasm01)

(sexfan02)
(sexpornB01)
(sexmastB01)

(sexcomm01)

if splitHalf == 1

, 
latent () 
standardized nocnsreport nocapslatent 
method(ml)  
vce(sbentler)
covstructure(_Ex, diagonal)				//setzt alle Varianzen auf 1 und alle Kovarianzen auf 0

;																							
																							
#delimit cr

//-----Testen der Modellgüte-----
estat gof, stats(all)

log close
