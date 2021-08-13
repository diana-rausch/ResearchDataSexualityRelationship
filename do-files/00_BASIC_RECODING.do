log using "${logDirectory}00_BASIC_RECODING.log", replace

/********** BASIC RECODINGS ************
Grundlegende Aufarbeitung der Variablen im Datensatz
Korrektur von Tippfehlern in den Variablen bei der Fragebogenerstellung
Entfernen unnötiger Variablen, die Unipark zusätzlich erhoben hat
Missing-Werte (-999, -99, 0) werden mit entsprechenden Missings recodiert
Zusammenführen der _m, _f und _misc Werte für die erhobenen Variablen, entfernen der einzelnen Variablen
Umcodieren von Variablen mit freier Texteingabe
*/


//************ Fehlerhafte Variablenbenennung korrigieren ************
rename coupetrust01_f coupletrust01_f
rename coupleduration_m coupleduration_month
rename coupleduration_y coupleduration_year
rename sexselfconf2 sexselfconf02
rename hhincome_orig_f hhincomeorig
rename contraceptsatis01 contraceptsat


//************ Entfernen unnötiger Variablen ************
drop lfdn 
drop external_lfdn 
drop tester 
drop lastpage 
drop quality 

drop browser 
drop referer 
drop device_type 
drop participant_browser 
drop participant_browser_version 
drop participant_os 
drop participant_device 
drop participant_brand 
drop participant_model 
drop participant_isbot 
drop participant_continent 
drop participant_country 
drop participant_region 
drop participant_city 
//drop participant_*				//<------------ entfernt alle participant_* Variablen von Unipark
drop quota 
drop quota_assignment 
drop page_history 

drop output_mode 
drop javascript 
drop flash 
drop session_id 
drop language 
drop cleaned 
drop ats 
drop date_of_last_access 
drop date_of_first_mail 
drop hflip
drop vflip

//drop rts*							//<------------ entfernt alle rts* Variablen von Unipark
drop rts4262553 
drop rts4262751
drop rts4264167 
drop rts4264168 
drop rts4264281 
drop rts4264413 
drop rts4264495 
drop rts4264519 
drop rts4264530 
drop rts4268049 
drop rts4277661 
drop rts4277675 
drop rts4277682 
drop rts4277877 
drop rts4277880 
drop rts4277884 
drop rts4296344 
drop rts4296358 
drop rts4296697 
drop rts4296698 
drop rts4296700 
drop rts4296701


//************ Missings umcodieren ************
//Schleife codiert alle Missings -999 und -99 um, für Zahl- und Textvariablen 

foreach var of varlist * {												//schaut sich alle Variablen des Datensatzes an
   capture confirm string variable `var'								//prüft und speichert in !_rc das Ergebnis, ob angeschaute Variable `var' vom Typ Text ist
   if !_rc {															//wenn !_rc "true" (d.h. Text Variable)
		replace `var' = ".z" if `var' == "-99"							//führe Text-Recodierung für Missings durch
		replace `var' = ".n" if `var' == "-999"
   }
   else {																//für alle anderen Variablen (Zahlen, Datum etc.)
		replace `var' = .n if `var' == -999								//führe Zahlen-Recodierung für Missings durch
		replace `var' = .m if `var' == 0
		replace `var' = .k if `var' == 99 	
   }
}
//
/*missings bekommen verschiendene Ausprägungen für spätere Nachvollziehbarkeit über tab var, missing
-999=.n 	- Frage nie gesehen (vorher abgebrochen oder anderer Weg)
0=.m		- Frage gesehen, aber nicht beantwortet (oder bei freien Antworten - Antwort nicht verwertbar)
-99=.z		- Frage gesehen, aber nicht zutreffend (keine freie Antwort notwendig, da bereits vorgegebene Antwort gewählt)
99=.k		- bei Praktiken Einstellungen 99 = "kann ich nicht beurteilen"

*/


//************ Zusammenführen von _m, _f, _misc ************

foreach var of varlist * {												//schaut sich alle Variablen des Datensatzes an
	if substr("`var'",-2,2) == "_f" | substr("`var'",-2,2) == "_m" | substr("`var'",-5,5) == "_misc"{		//prüft, ob substring (Text im Text) _f oder _m oder _misc, startet dabei -n Zeichen vor dem Ende, für n Zeichen
		local newvar = substr("`var'",1,strpos("`var'","_")-1)			//erstellt neue Systemvariable newvar, die den zukünftigen Namen der Einzelvariablen enthält, d.h. ohne _f etc. (strpos ist Position des Texts im Text, geht von Anfang bis 1 vor Unterstrich)
		capture confirm variable `newvar'								//prüft, ob Variable mit Namen existiert (um beim zweiten/dritten Durchlauf, d.h. bei _m oder _misc nicht noch einmal die gleiche Variable zu erstellen)
		if !_rc {														//falls Name schon existiert
			di in red "`newvar' exists"									//rot schreiben, dass es sie schon gibt
			} 
		else {															//andernfalls									
			//di in red "create `newvar'"									//rot schreiben, dass neue Variable mit entsprechendem Namen generiert wird
			egen `newvar' = rowmax(`newvar'_*)							//erzeugt neue Variable aus rowmax der bestehenden Einzelvariablen mit gleichem Namen
			label values `newvar' `: value label `var''					//überträgt die Antwort-Label der Einzelvariablen auf neue Gesamtvariable
			_crcslbl `newvar' `var'										//überträgt das Frage-Label der Einzelvariablen auf neue Gesamtvariable
			}
		drop `var'														//entfernt Einzelvariable
	}
}


//************ Umcodieren der invers formulierten Variablen ************
//notwendig, damit diese mit den anderen Variablen zusammengeführt und verglichen werden können

label define inv_label 1 "trifft voll und ganz zu" 7 "trifft überhaupt nicht zu"	//erstellt umgekehrte Label-Bezeichnung
foreach var of varlist sexquan03 sexdes02 sexselfconf01 sexmastA02 seximp02 sexsat04 couplequan02 partnerattr02 sexcomm01 healthment01 healthment02 healthphys01{	//schaut alle Variablen aus der Liste an (negativ codierte)
	local newvar = "`var'" + "_tmp"													//erzeugt Systemvariable newvar mit dem Namen der aktuell angeschauten Variablen_tmp
	local oldvar = "`var'" + "_inv"													//erzeugt Systemvariable oldvar mit dem Namen der aktuell angeschauten Variablen_inv 
	gen `newvar' = 8 - `var'														//erzeugt neue Variable mit dem namen von newvar (d.h. Variable_tmp) und als Inhalt den Wert 8-Variable (inverse Codierung)
	replace `newvar' = .m if `var' == .m 
	replace `newvar' = .n if `var' == .n
	order `newvar', before(`var')													//sortiert neue Variable vor der alten Variable ein
	_crcslbl `newvar' `var'															//überträgt Frage-Label der alten Variable auf die neue
	label values `newvar' inv_label													//überträgt Antwort-Label der erzeugten inversen Label auf die neue Variable
	rename `var' `oldvar'															//benennt die angeschaute Variable mit _inv
	rename `newvar' `var'															//benennt die neue Variable (die eben umcodierte) mit dem alten Namen
}	
//
																
																
																	
//************ Umcodieren freier Texteingaben ************


//----------- Alter -----------
tab age 
													//in der Umfrage wurde Geburtsjahr erhoben - daraus wird nun Alter generiert 
gen birthyear = age									//erhobene Daten (var age) werden in Variable Geburtsjahr (var birthyear) geschrieben 
replace age = . 									//Variable Alter aus Umfrage wird geleert

replace birthyear = 1942 if birthyear == 4192		//Umkodieren der Tippfehler bei den Geburtjahren
replace birthyear = 1948 if birthyear == 1948948	
replace birthyear = 1964 if birthyear == 4196
replace birthyear = 1965 if birthyear == 965
replace birthyear = 1966 if birthyear == 966
replace birthyear = 1971 if birthyear == 1071
replace birthyear = 1973 if birthyear == 73
replace birthyear = 1975 if birthyear == 75
replace birthyear = 1976 if birthyear == 976 | birthyear == 1076
replace birthyear = 1977 if birthyear == 1977977
replace birthyear = 1978 if birthyear == 978 | birthyear == 1978978
replace birthyear = 1979 if birthyear == 197917 | birthyear == 1197970 | birthyear == 1079 | birthyear == 1979979 | birthyear == 1197911
replace birthyear = 1981 if birthyear == 198111
replace birthyear = 1982 if birthyear == 19822 | birthyear == 198282 | birthyear == 82 | birthyear == 1082
replace birthyear = 1983 if birthyear == 83
replace birthyear = 1984 if birthyear == 984 | birthyear == 184 | birthyear == 1384 | birthyear == 1884
replace birthyear = 1985 if birthyear == 85 | birthyear == 1985198 | birthyear == 1885
replace birthyear = 1986 if birthyear == 986 | birthyear == 86 | birthyear == 986986
replace birthyear = 1987 if birthyear == 87 | birthyear == 7198
replace birthyear = 1988 if birthyear == 988
replace birthyear = 1989 if birthyear == 189 | birthyear == 89 | birthyear == 1889
replace birthyear = 1990 if birthyear == 9019 | birthyear == 2990 | birthyear == 990 | birthyear == 90
replace birthyear = 1991 if birthyear == 91 | birthyear == 191 | birthyear == 991 | birthyear == 1791 | birthyear == 1919 | birthyear == 199191
replace birthyear = 1992 if birthyear == 19922
replace birthyear = 1993 if birthyear == 193 | birthyear == 3199
replace birthyear = 1994 if birthyear == 94 | birthyear == 1194 | birthyear == 1994911
replace birthyear = 1995 if birthyear == 195 | birthyear == 1995199 | birthyear == 1195
replace birthyear = 1996 if birthyear == 196 | birthyear == 1196
replace birthyear = 1997 if birthyear == 197 | birthyear == 1197
replace birthyear = 1998 if birthyear == 198 | birthyear == 1198
replace birthyear = 1999 if birthyear == 199 | birthyear == 1199

replace birthyear = 2015 - 23 if birthyear == 20	//Umkodieren bei angegebenem Alter in Geburtsjahr
replace birthyear = 2015 - 21 if birthyear == 21
replace birthyear = 2015 - 23 if birthyear == 23
replace birthyear = 2015 - 25 if birthyear == 25
replace birthyear = 2015 - 29 if birthyear == 29
replace birthyear = 2015 - 31 if birthyear == 31
replace birthyear = 2015 - 47 if birthyear == 47

replace birthyear = .m if birthyear == 1			//nicht verwertbare Antworten als missing kennzeichnen
replace birthyear = .m if birthyear == 8	
replace birthyear = .m if birthyear == 1111
replace birthyear = .m if birthyear == 1119
replace birthyear = .m if birthyear == 1219
replace birthyear = .m if birthyear == 1234
replace birthyear = .m if birthyear == 1719
replace birthyear = .m if birthyear == 1900
replace birthyear = .m if birthyear == 1904
replace birthyear = .m if birthyear == 1917
replace birthyear = .m if birthyear == 1922
replace birthyear = .m if birthyear == 7984

replace age = 2015 - birthyear						//aus dem erhobenen Geburtsjahr wird nun Alter gemacht 
replace age = .m if birthyear == .m
replace age = .n if birthyear == .n
order age, before(birthyear)
tab age												//zeigt noch einmal neu erzeugte Altersvariable


//----------- Bildung -----------					
tab education 
tab education, nolabel

tab education_text 

replace education = 3 if strpos(education_text, "10 klassen oberschule")				//Umkodieren der freien Textangaben
replace education = 3 if strpos(education_text, "Berufsausbildung")
replace education = 4 if strpos(education_text, "Abgebrochenes Studium/ Vordiplom")
replace education = 4 if strpos(education_text, "Abi")
replace education = 4 if strpos(education_text, "Allgemeine Fachhochschulreife")
replace education = 3 if strpos(education_text, "Ausbildung")
replace education = 2 if strpos(education_text, "Beenden der Schulpflicht (9 Jahre, Schw")

replace education = 4 if strpos(education_text, "Berufsbildende H")
replace education = 3 if strpos(education_text, "Berufsfachschule")
replace education = 3 if strpos(education_text, "Berufslehre (Schweiz)")
replace education = 3 if strpos(education_text, "Berufsschule")
replace education = 6 if strpos(education_text, "Examen")

replace education = 4 if strpos(education_text, "Fachabit")
replace education = 4 if strpos(education_text, "Fachhochschul Reife")
replace education = 6 if strpos(education_text, "Fachhochschulabschluss")
replace education = 6 if strpos(education_text, "Fachhochschulsreife")
replace education = 6 if strpos(education_text, "Fachhochschule")
replace education = 6 if strpos(education_text, "Fachhochschule (Sozial")
replace education = 4 if strpos(education_text, "Fachhochschulreife")
replace education = 4 if strpos(education_text, "Fachoberschulreife")

replace education = 4 if strpos(education_text, "Fachschul")
replace education = 4 if strpos(education_text, "Fachwirt")
replace education = 4 if strpos(education_text, "Handwerksmeister")
replace education = 3 if strpos(education_text, "IHK")
replace education = 4 if strpos(education_text, "Industriefachwirt")
replace education = 3 if strpos(education_text, "Kauffrau")

replace education = 3 if strpos(education_text, "Konditor")		
replace education = 3 if strpos(education_text, "Lehre")
replace education = 4 if strpos(education_text, "Meister")
replace education = 4 if strpos(education_text, "Polytechnische Oberschule")
replace education = 6 if strpos(education_text, "gogin (aus D")
replace education = 1 if strpos(education_text, "lerin") 		
replace education = 2 if strpos(education_text, "Sonderschulabschluss")
replace education = 4 if strpos(education_text, "Techniker")
replace education = 6 if strpos(education_text, "VWA")
replace education = 5 if strpos(education_text, "Vordiplom")
replace education = 3 if strpos(education_text, "Zfa")		

replace education = 3 if strpos(education_text, "abgeschlossene Berufsausbildung")
replace education = 4 if strpos(education_text , "berufsbildende h") 
replace education = 4 if strpos(education_text, "fachabitur")
replace education = 4 if strpos(education_text, "fachgebundene")
replace education = 4 if strpos(education_text, "fachhochschulreife")
replace education = 4 if strpos(education_text , "DDR als GS-Lehre")
replace education = 4 if strpos(education_text, "fachwirt")
replace education = 7 if strpos(education_text, "habil")
replace education = 2 if strpos(education_text, "quali")
replace education = 3 if strpos(education_text, "sekabschluss")
replace education = 4 if strpos(education_text , "was ist")

tab education																	//hier dürfte es Kategorie 8 (anderes) nicht mehr geben
replace education = .m if education_text == ".z" & education == 8				//entfernen des Einzelfalls, dass "anderes" angekreuzt wurde, aber dann nicht angegeben wurde

//----------- Beziehungstyp -----------
tab coupletype
tab coupletype, nolabel

tab coupletype_text
list coupletype_text if coupletype_text != ".z" & coupletype_text != ".n"		//ermöglicht Lesen der gesamten Antwort

replace coupletype = 1 if strpos(coupletype_text, "Derzeit noch")				//Umkodieren der freien Textangaben
replace coupletype = 5 if strpos(coupletype_text, "1 Mann, ein")
replace coupletype = 5 if strpos(coupletype_text, "1 Prim")
replace coupletype = 5 if strpos(coupletype_text, "2,5 Kuschelbeziehungen")
replace coupletype = 3 if strpos(coupletype_text, "Aff") 
replace coupletype = 1 if strpos(coupletype_text, "Anfang vom kennen lernen")
replace coupletype = 1 if strpos(coupletype_text, "Auszeit")
replace coupletype = 2 if strpos(coupletype_text, "Beginn einer festen Beziehung")
replace coupletype = 1 if strpos(coupletype_text, "Beziehung beendet")
replace coupletype = 1 if strpos(coupletype_text, "Beziehung in Trennung")
replace coupletype = 5 if strpos(coupletype_text, "Beziehung mit 1 Partner")
replace coupletype = 5 if strpos(coupletype_text, "Beziehung mit verheirateter Frau")

replace coupletype = 1 if strpos(coupletype_text, "Dates hier, Dates da")
replace coupletype = 1 if strpos(coupletype_text, "Explizit polyamor")	
replace coupletype = .m if strpos(coupletype_text, "Fachschule")							//missing
replace coupletype = 2 if strpos(coupletype_text, "Fernbeziehung")
replace coupletype = 2 if strpos(coupletype_text, "Fernbeziehung mit befreundetem Mann")
replace coupletype = 5 if strpos(coupletype_text, "Fest liiert, aber auch Sex mit einem an")
replace coupletype = 5 if strpos(coupletype_text, "Feste Beziehung und wechselnde")
replace coupletype = 3 if strpos(coupletype_text, "Feste Beziehung. Aber swinger")
replace coupletype = 2 if strpos(coupletype_text, "Feste geheime Liebschaft")
replace coupletype = 3 if strpos(coupletype_text, "Fester Partner mit geleg. Partnertausch")
replace coupletype = 3 if strpos(coupletype_text, "Fester Partner, eine gemeinsame Sexpart")
replace coupletype = 3 if strpos(coupletype_text, "Freies Dating")
replace coupletype = 3 if strpos(coupletype_text, "Freundschaft + ohne Verpflichtungen")
replace coupletype = 3 if strpos(coupletype_text, "Freundschaft Plus")
replace coupletype = 3 if strpos(coupletype_text, "Freundschaft mit Extras mit 2 festen")
replace coupletype = 3 if strpos(coupletype_text, "Freundschaft plus")
replace coupletype = 5 if strpos(coupletype_text, "Frisch getrennt plus") 				

replace coupletype = 1 if strpos(coupletype_text, "Gerade frisch getrennt, aber immer noch")
replace coupletype = 1 if strpos(coupletype_text, "Getrennt lebend")
replace coupletype = 1 if strpos(coupletype_text, "Im Moment beziehungspause")
replace coupletype = 2 if strpos(coupletype_text, "Liebschaft")
replace coupletype = 2 if strpos(coupletype_text, "Monogame Beziehung")
replace coupletype = 2 if strpos(coupletype_text, "Monogame Beziehung, aber nicht fest")
replace coupletype = .m if strpos(coupletype_text, "Schwierig")								//missing
replace coupletype = 4 if strpos(coupletype_text, "Sexfreunde mit mehreren Partnern, die s")
replace coupletype = 1 if strpos(coupletype_text, "Single")
replace coupletype = 4 if strpos(coupletype_text, "Single aber 2-3 Freundschaft+ -Beziehu")
replace coupletype = 4 if strpos(coupletype_text, "Single, mit ein paar Fuckbody M")
replace coupletype = 1 if strpos(coupletype_text, "Stetig wechselnde Partnerinnen")

replace coupletype = 3 if strpos(coupletype_text, "Teiloffene Beziehung mit festen Partner")
replace coupletype = 2 if strpos(coupletype_text, "Verheiratet")
replace coupletype = 5 if strpos(coupletype_text, "Verheiratet, mit Aff") 
replace coupletype = 5 if strpos(coupletype_text, "Verheiratet, sexueller Kontakt zu einem")
replace coupletype = 2 if strpos(coupletype_text, "Verlobt")
replace coupletype = 2 if strpos(coupletype_text, "Verwitwet Liebhaber")

replace coupletype = 2 if strpos(coupletype_text, "beziehung mit ex-partner")
replace coupletype = 1 if strpos(coupletype_text, "derzeit keine Beziehung")
replace coupletype = 1 if strpos(coupletype_text, "eher Freundschaft, ohne Sex")
replace coupletype = 2 if strpos(coupletype_text, "eingetragene Lebenspartnerschaft")
replace coupletype = 2 if strpos(coupletype_text, "es wird hoffentlich ne Beziehung")
replace coupletype = 4 if strpos(coupletype_text, "feste Beziehung (Ehe) mit polygamen Ein")
replace coupletype = 2 if strpos(coupletype_text, "feste Beziehung mit einer Aff") 
replace coupletype = 3 if strpos(coupletype_text, "feste Beziehung, gemeinsam sex mit ande")
replace coupletype = 3 if strpos(coupletype_text, "feste beziehung mit gemeinsamen dritten")
replace coupletype = 3 if strpos(coupletype_text, "fester Partner, nicht monogam, nicht offen")
replace coupletype = 3 if strpos(coupletype_text, "freundschaft +")
replace coupletype = 4 if strpos(coupletype_text, "freundschaft plus mit mehreren partnern")

replace coupletype = 2 if strpos(coupletype_text, "ckliche Beziehung mit einem")
replace coupletype = .m if strpos(coupletype_text, "ich lehne diese kategorisierung ab")	//missing
replace coupletype = 2 if strpos(coupletype_text, "in einer festen Beziehung")	
replace coupletype = 1 if strpos(coupletype_text, "jemanden kennen gelernt, Status noch")
replace coupletype = 1 if strpos(coupletype_text, "keine Beziehung")
replace coupletype = 3 if strpos(coupletype_text, "keine Beziehung, fester Sexualpartner")
replace coupletype = 1 if strpos(coupletype_text, "keine feste Beziehung, ")
replace coupletype = 2 if strpos(coupletype_text, "langjährige Aff")			
replace coupletype = 3 if strpos(coupletype_text, "lose, offenne fernbeziehung")
replace coupletype = 2 if strpos(coupletype_text, "mein fester Partner betr")
replace coupletype = 2 if strpos(coupletype_text, "monogam mit Partnerin")
replace coupletype = 2 if strpos(coupletype_text, "monogam mit festem partner, ohne beziehung")

replace coupletype = 3 if strpos(coupletype_text, "nicht monogame Beziehung mit einem fest")
replace coupletype = 1 if strpos(coupletype_text, "noch nie eine Beziehung")
replace coupletype = 2 if strpos(coupletype_text, "platonische Dauerbeziehung")
replace coupletype = 2 if strpos(coupletype_text, "qualvolle feste beziehung in der ich")
replace coupletype = 1 if strpos(coupletype_text, "single")
replace coupletype = 1 if strpos(coupletype_text, "solo")
replace coupletype = 1 if strpos(coupletype_text, "unfreiwilliges Z")
replace coupletype = 2 if strpos(coupletype_text, "ungewiss. er lebt")
replace coupletype = 2 if strpos(coupletype_text, "verheiratet")
replace coupletype = 5 if strpos(coupletype_text, "verheiratet und einen geliebten")
replace coupletype = 3 if strpos(coupletype_text, "verheiratet und offen")
replace coupletype = 3 if strpos(coupletype_text, "verheiratet, aber wir sind Swinger")
replace coupletype = 5 if strpos(coupletype_text, "verheiratet, mit neuer anderer Liebesbeziehung")
replace coupletype = 1 if strpos(coupletype_text, "verwitwet")

tab coupletype																		//hier dürfte es Kategorie 6 (anderes) nicht mehr geben
replace coupletype = .m if coupletype_text == ".z" & coupletype == 6				//entfernen der zwei Fälle, dass "anderes" angekreuzt wurde, aber dann nicht angegeben wurde


//----------- Verhütung -----------
tab contracept10_text
list contracept10_text if contracept10_text != ".z" & contracept10_text != ".n"

//Verhütung - freie Textangaben zuordnen
replace contracept01 = 1 if strpos(contracept10_text, "Aufpassen")
replace contracept04 = 1 if strpos(contracept10_text, "Spritze")
replace contracept04 = 1 if strpos(contracept10_text, "spritze")
replace contracept04 = .m if strpos(contracept10_text, "Als Mann")
replace contracept01 = 1 if strpos(contracept10_text, "CI")
replace contracept01 = 1 if strpos(contracept10_text, "Coitus")				
replace contracept09 = 1 if strpos(contracept10_text, "Vasektomie")
replace contracept01 = 1 if strpos(contracept10_text, "Enthaltsamkeit")
replace contracept08 = 1 if strpos(contracept10_text, "tsmonitor")			
replace contracept08 = 1 if strpos(contracept10_text, "Persona")			
replace contracept06 = 1 if strpos(contracept10_text, "bchen")
replace contracept06 = 1 if strpos(contracept10_text, "Implantat")
replace contracept05 = 1 if strpos(contracept10_text, "ring")
replace contracept07 = 1 if strpos(contracept10_text, "IUB")
replace contracept01 = 1 if strpos(contracept10_text, "unfruchtbar")		
replace contracept06 = 1 if strpos(contracept10_text, "Implano")
replace contracept03 = 1 if strpos(contracept10_text, "Pille")
replace contracept01 = 1 if strpos(contracept10_text, "Kein Sex")
replace contracept02 = 1 if strpos(contracept10_text, "Kondom")				
replace contracept06 = 1 if strpos(contracept10_text, "Langzeit")						//nimmt an, dass die Langzeitverhütung hormonell ist

replace contracept02 = 1 if strpos(contracept10_text, "Latexhandschuhe zur STI")
replace contracept09 = 1 if strpos(contracept10_text, "sterilisiert")
replace contracept05 = 1 if strpos(contracept10_text, "Ring")
replace contracept01 = 1 if strpos(contracept10_text, "Schlucken")				
replace contracept01 = 1 if strpos(contracept10_text, "Schwangerschaft")
replace contracept06 = 1 if strpos(contracept10_text, "Spirale liegt")		
replace contracept09 = 1 if strpos(contracept10_text, "Sterilisation beim")
replace contracept01 = 1 if strpos(contracept10_text, "Unfruchtbar")
replace contracept01 = 1 if strpos(contracept10_text, "anal")
replace contracept02 = 1 if strpos(contracept10_text, "kondom")				
replace contracept01 = 1 if strpos(contracept10_text, "das Alter")
replace contracept09 = 1 if strpos(contracept10_text, "Verlust der")
replace contracept03 = 1 if strpos(contracept10_text, "freundin pille")
replace contracept01 = 1 if strpos(contracept10_text, "homosex")
replace contracept06 = 1 if strpos(contracept10_text, "implantat")

replace contracept06 = 1 if strpos(contracept10_text, "ich stelle grade von Minipille auf")
replace contracept06 = 1 if strpos(contracept10_text, "implanon")
replace contracept07 = 1 if strpos(contracept10_text, "iub")
replace contracept02 = 1 if strpos(contracept10_text, "je nach Partner Kombination")	//Kondom + Kupferspirale
replace contracept08 = 1 if strpos(contracept10_text, "ladycomp")
replace contracept01 = 1 if strpos(contracept10_text, "lesbischer Sex")
replace contracept01 = 1 if strpos(contracept10_text, "schwanger, danach")
replace contracept03 = 1 if strpos(contracept10_text, "morea")
replace contracept09 = 1 if strpos(contracept10_text, "sterilisation")
replace contracept09 = 1 if strpos(contracept10_text, "vasektomie")						
replace contracept01 = 1 if strpos(contracept10_text, "zu alt")
replace contracept03 = 1 if strpos(contracept10_text, "wegen Sterilisation")			//nur Zusatzinfo, verhütet aber mit Pille

//teilweise ändert Zuordnung der Textangaban nichts, da bereits vorher die richtigen Kategorien angekreuzt wurden 
//und das Feld nur als spezifische Zusatzinformation genutzt wurde
//teilweise auch mehrere Angaben (Kondom, Pille etc.), sind dann alle in der untersch. Variablen erhoben

log close
