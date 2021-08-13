log using "${logDirectory}02_Variablen_Review_Indexbildung.log", replace


//------------ VARIABLEN REVIEW + INDEXBILDUNG -----------


//----------- sexuelle Orientierung -----------
replace sexorient = .m if sexorient == 6					//6 - lehne Kategorisierung ab - als Missing umcodiert
gen sexorient_het = sexorient
replace sexorient_het = .z if sexorient_het > 3 & sexorient_het != .m & sexorient != .n				//entfernt homosexuelle Orientierung
recode sexorient_het (1=3) (2=2) (3=1)			//label		//Umskalieren der Orientierungsskala für heterosexuelle auf 3er Skala	
label define sexorient_het 3 "ausschließich heterosexuell" 2 "vorwiegend heterosexuell" 1 "bisexuell"
label values sexorient_het sexorient_het				
tab sexorient_het, missing															

													
//----------- Einkommen -----------
replace hhincome = .m if hhincome == 11						//11 - keine Angabe - als Missing umcodiert
tab hhincome, missing


//----------- Haushalt Größe -----------
replace hhsize_a = .m if hhsize_a == 75						//macht Angabe "75 Erwachsene in einem Haushalt" zumissing																		
egen hhsize = rowtotal (hhsize_a hhsize_c)					//rowtotal behandelt missings wie 0 (dadurch werden vorherige 0-missings wieder vergeben)
replace hhsize = .m if hhsize == 0							//0-missings wieder zu echten missings machen
order hhsize, before (hhsize_a)
tab hhsize, missing	


//----------- Fantasien -----------
egen sexfan = rowmean (sexfan01 sexfan02)
replace	sexfan = .m if sexfan01 == .m & sexfan02 == .m
replace sexfan = .n if sexfan == .	
tab sexfan, missing


//----------- sexuell aktiv seit wann (Alter) -----------
replace sexact_time = .m if sexact_time < 10				//entfernt Fälle, in denen Alter für erster Sex <10 oder Alter < als Alter für erster Sex
replace sexact_time = .m if sexact_time > age & sexact_time != .n
																							
	
//----------- Häufigkeit Sex -----------
replace sexquan01 = 0 if sexquan01 == .m		//number	//0-Angaben, die vorher zu Missings gemacht wurden
replace sexquan01 = .m if sexquan01 > 40					//entfernt alle Angaben, die mehr als 40 mal Sex im Monat haben

gen sexquan = .												//Häufigkeit kategorisieren
replace sexquan = 1 if sexquan01 == 0						//nie, ein paar Mal im Jahr, ein paar Mal im Monat, 2 bis 3 pro Woche, 4 oder mehr pro Woche
replace sexquan = 2 if sexquan01 > 0	
replace sexquan = 3 if sexquan01 > 3
replace sexquan = 4 if sexquan01 > 9
replace sexquan = 5 if sexquan01 > 17


//----------- Praktiken -----------
egen sexactBcount = anycount (sexactB01-sexactB05), values(4 5 6 7)	//Index für "grundlegende Sex Praktiken finden statt"
replace sexactBcount = .m if sexactB01 - sexactB05 == .m
replace sexactBcount = .n if sexactBcount == .
tab sexactBcount, missing

gen sexactSuccess01 = 0											//Praktiken operationalisieren - Praktiken, die man mag
gen sexactSuccess02 = 0
gen sexactSuccess03 = 0
gen sexactSuccess04 = 0
gen sexactSuccess05 = 0
gen sexactSuccess06 = 0
gen sexactSuccess07 = 0

replace sexactSuccess01 = 1 if sexactB01 > 3 & sexactA01 > 4	//Praktik ist regelmäßig Bestandteil und wird gemocht
replace sexactSuccess02 = 1 if sexactB02 > 3 & sexactA02 > 4
replace sexactSuccess03 = 1 if sexactB03 > 3 & sexactA03 > 4
replace sexactSuccess04 = 1 if sexactB04 > 3 & sexactA04 > 4
replace sexactSuccess05 = 1 if sexactB05 > 3 & sexactA05 > 4
replace sexactSuccess06 = 1 if sexactB06 > 3 & sexactA06 > 4
replace sexactSuccess07 = 1 if sexactB07 > 3 & sexactA07 > 4

egen sexactSuccess = rowtotal(sexactSuccess01 sexactSuccess02 sexactSuccess03 sexactSuccess04 sexactSuccess05 sexactSuccess06 sexactSuccess07)

drop sexactSuccess01 sexactSuccess02 sexactSuccess03 sexactSuccess04 sexactSuccess05 sexactSuccess06 sexactSuccess07

gen sexactFailure01 = 0
gen sexactFailure02 = 0
gen sexactFailure03 = 0
gen sexactFailure04 = 0
gen sexactFailure05 = 0
gen sexactFailure06 = 0
gen sexactFailure07 = 0

replace sexactFailure01 = -1 if sexactB01 > 3 & sexactA01 < 4	//Praktik ist regelmäßig Bestandteil und wird nicht gemacht
replace sexactFailure02 = -1 if sexactB02 > 3 & sexactA02 < 4	//<----ACHTUNG! Alle mittleren (4) Attitudes-Werte erhalten eine 0
replace sexactFailure03 = -1 if sexactB03 > 3 & sexactA03 < 4
replace sexactFailure04 = -1 if sexactB04 > 3 & sexactA04 < 4
replace sexactFailure05 = -1 if sexactB05 > 3 & sexactA05 < 4
replace sexactFailure06 = -1 if sexactB06 > 3 & sexactA06 < 4
replace sexactFailure07 = -1 if sexactB07 > 3 & sexactA07 < 4

egen sexactFailure = rowtotal(sexactFailure01 sexactFailure02 sexactFailure03 sexactFailure04 sexactFailure05 sexactFailure06 sexactFailure07)

drop sexactFailure01 sexactFailure02 sexactFailure03 sexactFailure04 sexactFailure05 sexactFailure06 sexactFailure07

gen sexactBalance = sexactSuccess + sexactFailure				//zieht negative Erfahrungen von Gesamtindex ab

egen sexactAmissingcount = rowmiss (sexactA01 sexactA02 sexactA03 sexactA04 sexactA05 sexactA06 sexactA07)
egen sexactBmissingcount = rowmiss (sexactB01 sexactB02 sexactB03 sexactB04 sexactB05 sexactB06 sexactB07)


//----------- Praktiken - Einstellungen -----------			//99 - "kann ich nicht beurteilen", als missing umcodiert
egen sexactAcount = anycount (sexactA01 - sexactA15), values(4 5 6 7)			//alle Praktiken
replace sexactAcount = .m if sexactA01 - sexactA15 == .m 
replace sexactAcount = .n if sexactAcount == .
replace sexactAcount = .k if sexactAcount == 0 									//<----- entfernt alle, die nach Aufsummieren 0 haben, d.h. bei allen Praktiken keine Angaben gemacht haben
tab sexactAcount, missing

egen sexactAcountother = anycount (sexactA06 - sexactA15), values(4 5 6 7)		//nur besondere Praktiken
replace sexactAcountother = .m if sexactA06 - sexactA15 == .m 
replace sexactAcountother = .n if sexactAcountother == .
replace sexactAcountother = .k if sexactAcountother == 0 						//<----- entfernt alle, die nach Aufsummieren 0 haben, d.h. bei allen Praktiken keine Angaben gemacht haben
tab sexactAcountother, missing


//----------- Beziehungsdauer -----------
gen coupleduration_year_month = .													//generiert neue, leere Variable, die Beziehungsjahre in Monaten umgerechnet enthalten soll
replace coupleduration_year_month = coupleduration_year * 12						//füllt leere Variable mit Beziehungsjahren umgerechnet in Monate
egen coupleduration = rowtotal (coupleduration_month coupleduration_year_month)		//rowtotal behandelt missings wie 0 -> füllt neue Variable coupleduration mit Monaten + Jahren (in Monaten)
replace coupleduration = coupleduration/12											//wandelt Angabe in Jahre um
replace coupleduration = .m if coupleduration/12 > age								//entfernt unsinnige Werte, für die Beziehungsdauer größer ist als Alter
drop if coupleduration == 0	

tab coupleduration, missing		
sum coupleduration, detail	


//----------- Kategorisieren von Beziehungsdauer in drei Teile -----------

egen coupledurationCat = cut(coupleduration), group(3)
recode coupledurationCat (0=1)(1=2)(2=3)
tab coupledurationCat, missing


//----------- Offenheit für Erfahrungen (Big 5) -----------
egen bigfiveO = rowmean (bigfiveO01 bigfiveO02)				
replace	bigfiveO = .m if bigfiveO01 == .m & bigfiveO02 == .m
replace bigfiveO = .n if bigfiveO == .
tab bigfiveO, missing


//Alternative zum Messmodell für SEM mit Mittelwerten der latenten Variablen
egen sexsatMean = rowmean (sexsat01 sexsat02 sexsat03)
egen coupleMean = rowmean (couplebond01 couplebond02 coupleint01)
egen distractMean = rowmean (sexnet01 sexnet02)				

log close
