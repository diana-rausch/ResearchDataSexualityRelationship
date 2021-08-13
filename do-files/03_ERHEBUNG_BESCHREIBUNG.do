log using "${logDirectory}03_Erhebung_Stichprobe_Beschreibung.log", replace


/********** ERHEBUNG BESCHREIBUNG ************
Beschreibung der Erhebung und Stichprobe
*/

//************ Statistik über Erhebung | Anzahl, Dauer ************
	
tab datetime 						//22.04.2015-17.07.2015
tab dispcode 						//22 unterbrochen, 31 beendet, 32 beendet nach Unterbrechung | 2768 beendet + beendet nach Unterbrechung
sum duration, detail				//mean 914
sum duration if dispcode==31		//von denen, die es am Stück ausgefüllt haben, ist mean 1279


tab gender dispcode											//insgesamt 1920 Frauen Fragebogen beendet


//************ Statistik über Stichprobe - Demografie ************

tab gender, missing						

tab age, missing
sum age, detail

tab education, missing	 						//label		//1 bis 7 - kein Schulabschluss bis Promotion | nach Zuordnung der freien Textangaben entfällt Kategorie 8

tab urban, missing								//label		//bis 7 - < 10k bis > 500k

tab hhincome, missing								

tab hhsize_a, missing							//number
tab hhsize_a hhsize_c, missing						


tab religion, missing							//label		//1 bis 8, 1 keine

tab polatt, missing											//1 bis 11, links bis rechts



//************ Statistik über Stichprobe - sexueller Hintergrund ************

tab sexorient, missing							//label		//1 bis 5 - heterosexuell bis homosexuell | 6 "lehne Kategorisierung ab

tab partnergender, missing	 					//label		//1 weiblich, 2 männlich, 3 andere

replace coupleduration = .m if coupleduration == 0			//<----- entfernt Leute aus coupleduration, die keine Angabe gemacht haben, obwohl in Beziehung
tab coupleduration, missing		
sum coupleduration, detail	

tab coupletype, missing							//label		//1 bis 6 | 1 keine, 2 monogam, 3 offen, 4 Partner, die sich kennen, 5 Partner, die sicht nicht kennen, 6 anderes
tab coupletype gender										//knapp 2000 Frauen mit Beziehung

log close


//------------------------------------------------------


log using "${logDirectory}03_Erhebung_Variablen_Beschreibung.log", replace


//************ benutzte Variablen Beschreibung + Kurtosis, Skewness, Sktest, SWilk ************

//Beschreibung

tab gender, missing

gen ageCat = .												//Alterskategorien
replace ageCat = 1 if age <18
replace ageCat = 2 if age >17 & age <25
replace ageCat = 3 if age >24 & age <30
replace ageCat = 4 if age >29 & age <35
replace ageCat = 5 if age >34 & age <40
replace ageCat = 6 if age >39 & age <45
replace ageCat = 7 if age >44 & age <50
replace ageCat = 8 if age >49
replace ageCat = .m if age == .m
tab ageCat, missing

tab ageCat gender, missing

gen coupledurationCatZehn = .
replace coupledurationCatZehn = 1 if coupleduration <=1
replace coupledurationCatZehn = 2 if coupleduration >1 & coupleduration <=2
replace coupledurationCatZehn = 3 if coupleduration >2 & coupleduration <=3
replace coupledurationCatZehn = 4 if coupleduration >3 & coupleduration <=4
replace coupledurationCatZehn = 5 if coupleduration >4 & coupleduration <=5
replace coupledurationCatZehn = 6 if coupleduration >5 & coupleduration <=6
replace coupledurationCatZehn = 7 if coupleduration >6 & coupleduration <=7
replace coupledurationCatZehn = 8 if coupleduration >7 & coupleduration <=8
replace coupledurationCatZehn = 9 if coupleduration >8 & coupleduration <=9
replace coupledurationCatZehn = 10 if coupleduration >9 & coupleduration <=10
replace coupledurationCatZehn = 11 if coupleduration >10

tab coupledurationCatZehn, missing

//endogen
sum sexactBalance sexorgasm01 sexquan sexfan02
sum sexactBalance sexorgasm01 sexquan sexfan02, detail

sktest sexactBalance sexorgasm01 sexquan sexfan02, noadjust
swilk sexactBalance sexorgasm01 sexquan sexfan02

//endogen - Messmodell
sum sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexsat01 sexsat02 sexsat03
sum sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexsat01 sexsat02 sexsat03, detail 

sktest sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexsat01 sexsat02 sexsat03, noadjust
swilk sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexsat01 sexsat02 sexsat03

//exogen 
sum sexmastB01 sexpornB01 sexcomm01
sum sexmastB01 sexpornB01 sexcomm01, detail

sktest sexmastB01 sexpornB01 sexcomm01, noadjust
swilk sexmastB01 sexpornB01 sexcomm01


//Kontrollvariablen

sum age education stress01 healthphys01 bigfiveO coupleduration
sum age education stress01 healthphys01 bigfiveO coupleduration, detail

sktest age education stress01 healthphys01 bigfiveO coupleduration, noadjust
swilk age education stress01 healthphys01 bigfiveO coupleduration


//Verteilung und missings Tabellen

tab1 sexactBalance sexorgasm01 sexquan sexfan02, missing nolabel

tab1 sexactA01-sexactA07, missing nolabel
tab1 sexactB01-sexactB07, missing nolabel
tab1 sexactSuccess sexactFailure sexactBalance, missing nolabel

tab1 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexsat01 sexsat02 sexsat03, missing nolabel
tab1 sexmastB01 sexpornB01 sexcomm01, missing nolabel

tab1 ageCat education stress01 healthphys01 bigfiveO coupledurationCatZehn, missing nolabel

log close
