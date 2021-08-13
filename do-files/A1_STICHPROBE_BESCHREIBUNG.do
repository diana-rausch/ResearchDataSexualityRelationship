log using "${logDirectory}A1_Stichprobe_Beschreibung_alle.log", replace

//####### Beschreibung der gesamten Stichprobe ######

tab gender, missing

tab ageCat gender, missing

tab education, missing
tab education gender, missing

tab hhincome, missing
tab hhincome gender, missing

tab religion, missing
tab religion gender, missing

tab polatt, missing
tab polatt gender, missing
sum polatt
sum polatt if gender == 1
sum polatt if gender == 2

tab coupletype, missing
tab coupletype gender, missing

tab sexorient, missing
tab sexorient gender, missing

tab datetime 						//22.04.2015-17.07.2015
tab dispcode 						//22 unterbrochen, 31 beendet, 32 beendet nach Unterbrechung | 2768 beendet + beendet nach Unterbrechung
sum duration, detail				//mean 914
sum duration if dispcode==31		//von denen, die es am Stück ausgefüllt haben, ist mean 1279

log close


log using "${logDirectory}00_Stichprobe_Beschreibung_Frauen.log", replace

//####### Beschreibung der eingeschränkten Stichprobe (nur Frauen in Bez.) ######

tab ageCat, missing

tab ageCat gender, missing

tab education, missing
tab education gender, missing

tab hhincome, missing
tab hhincome gender, missing

tab religion, missing
tab religion gender, missing

tab polatt, missing
tab polatt gender, missing
sum polatt
sum polatt if gender == 1
sum polatt if gender == 2

tab coupletype, missing
tab coupletype gender, missing

tab sexorient, missing
tab sexorient gender, missing


log close
