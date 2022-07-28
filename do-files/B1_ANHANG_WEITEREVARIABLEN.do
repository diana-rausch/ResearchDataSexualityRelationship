log using "${logDirectory}B1_ANHANG_WEITEREVARIABLEN.log", replace

//-----------Erstellung ungenutzter IndexVariablen--------------


//----------- Religion -----------							
gen religion_yes = .						
replace religion_yes = 1 if religion > 1
replace religion_yes = 0 if religion == 1
replace religion_yes = .n if religion == .n
replace religion_yes = .m if religion == .m
tab religion_yes, missing


//----------- Ablenkende Gedanken -----------
egen sexnet = rowmean (sexnet01 sexnet03 sexnet04)
replace sexnet = .m if sexnet01 == .m & sexnet03 == .m & sexnet04 == .m
replace sexnet = .n if sexnet == .
tab sexnet, missing


//----------- Sexuelles Verlangen -----------							
egen sexdes = rowmean (sexdes01 sexdes02)					
replace sexdes = .m if sexdes01 == .m & sexdes02 == .m		 
replace sexdes = .n if sexdes == .	
tab sexdes, missing


******
gen sexexp = .												
replace sexexp = age - sexact_time	
replace sexexp = .m if age == .m | sexact_time == .m		
replace sexexp = .n if age == .n | sexact_time == .n
tab sexexp, missing	


//----------- Wichtigkeit Sex -----------								 
egen seximp = rowmean (seximp01 seximp02)
replace	seximp = .m if seximp01 == .m & seximp02 == .m
replace seximp = .n if seximp == .	
tab	seximp, missing


//----------- Orgasmus -----------			
egen sexorgasm = rowmean (sexorgasm01 sexorgasm02)
replace	sexorgasm = .m if sexorgasm01 == .m & sexorgasm02 == .m
replace sexorgasm = .n if sexorgasm == .	
tab sexorgasm, missing


//--- Paraphilie ---
egen sexsadoall = rowmean(sexactA16-sexactA21)
replace sexsadoall = .m if sexactA16 - sexactA21 == .m
replace sexsadoall =.n if sexsadoall == .
tab sexsadoall, missing

egen sexsadosoft = rowmean (sexactA16-sexactA18)			
replace sexsadosoft = .m if sexactA16 - sexactA18 == .m
replace sexsadosoft =.n if sexsadosoft == .
tab sexsadosoft, missing

egen sexsadohard = rowmean (sexactA19-sexactA21)
replace sexsadohard = .m if sexactA19 - sexactA21 == .m
replace sexsadohard =.n if sexsadohard == .
tab sexsadohard, missing

egen sexmasoall = rowmean(sexactA24-sexactA29)	
replace sexmasoall = .m if sexactA24 - sexactA29 == .m
replace sexmasoall = .n if sexmasoall == .
tab sexmasoall, missing

egen sexmasosoft = rowmean (sexactA24-sexactA26)
replace sexmasosoft = .m if sexactA24 - sexactA26 == .m
replace sexmasosoft = .n if sexmasosoft == .
tab sexmasosoft, missing
		
egen sexmasohard = rowmean (sexactA27-sexactA29)
replace sexmasohard = .m if sexactA27 - sexactA29 == .m
replace sexmasohard = .n if sexmasohard == .
tab sexmasohard, missing

pwcorr sexactA22 sexactA23, sig											
egen sexbiastoakt = rowmean (sexactA22 sexactA23)
replace sexbiastoakt = .m if sexactA22 & sexactA23 == .m
replace sexbiastoakt = .n if sexbiastoakt == .
tab sexbiastoakt, missing

pwcorr sexactA30 sexactA31, sig		
egen sexbiastopass = rowmean (sexactA30 sexactA31)
replace sexbiastopass = .m if sexactA30 & sexactA31 == .m
replace sexbiastopass = .n if sexbiastopass == .
tab sexbiastopass, missing


//----------- Pornografie -----------						
egen sexpornA = rowmean (sexpornA01 sexpornA02)
replace sexpornA = .m if sexpornA01 == .m & sexpornA02 ==.m
replace sexpornA = .n if sexpornA ==.
tab sexpornA, missing
						
egen sexpornB = rowmean (sexpornB01 sexpornB02)
replace sexpornB = .m if sexpornB01 == .m & sexpornB02 ==.m
replace sexpornB = .n if sexpornB ==.
tab sexpornB, missing


//----------- sexuelle Handlungen mit dem gleichen Geschlecht -----------
egen sexbisex = rowmean (sexbisexA01 sexbisexA02)
replace sexbisex = .m if sexbisexA01 == .m & sexbisexA01 ==.m
replace sexbisex = .n if sexbisex ==.
tab sexbisex, missing


//----------- Treuebegriff -----------										
egen faithcount = rowtotal (faith01 faith02 faith03 faith04 faith05 faith06 faith07)
replace faithcount = 0 if faith08 == 1						//umcodieren der Fälle, in denen "keine Aktivität ist Untreue", aber trotzdem Aktivitäten angekreuzt wurdne
order faithcount, before(faith01)		
replace faithcount = .m if faith01 - faith08 == .m
replace faithcount = .n if faith01 - faith08 == .n
tab faithcount, missing 

egen faithlimitcount = rowtotal (faithlimit01 faithlimit02 faithlimit03 faithlimit04 faithlimit05 faithlimit06 faithlimit07)
replace faithlimitcount = 7 if faithlimit08 == 1			//umcodieren der Fälle, in denen "alles verzeihen", aber trotzdem Aktivitäten angekreuzt wurden
order faithlimitcount, before(faithlimit01)
replace faithlimitcount = .m if faithlimit01 - faithlimit08 == .m
replace faithlimitcount = .n if faithlimit01 - faithlimit08 == .n
tab faithlimitcount, missing


//----------- Beziehung Qualität -----------
egen couplequal = rowmean (couplequal01 couplequal02)		
replace couplequal = .m if couplequal01 == .m & couplequal02 == .m
replace couplequal = .n if couplequal == . 
tab couplequal, missing
 

//----------- Beziehung Bindungsstärke -----------
egen couplebond = rowmean (couplebond01 couplebond02)	
replace couplebond = .m if couplebond01 == .m & couplebond02 == .m
replace couplebond = .n if couplebond == . 
tab couplebond, missing
 

//----------- Beziehung Intimität -----------			
egen coupleint = rowmean (coupleint01 coupleint02)
replace coupleint = .m if coupleint01 == .m & coupleint02 == .m
replace coupleint = .n if coupleint == . 
tab coupleint, missing


//----------- Beziehung Vertrauen -----------
egen coupletrust = rowmean (coupletrust01 coupletrust02)
replace coupletrust = .m if coupletrust01 == .m & coupletrust02 == .m
replace coupletrust = .n if coupletrust == . 
tab coupletrust, missing


//----------- Kommunikation -----------
egen gencomm = rowmean (gencomm01 gencomm02 coupleint03)
replace gencomm = .m if gencomm01 == .m & gencomm02 == .m & coupleint03 == .m
replace gencomm = .n if gencomm == . 
tab gencomm, missing


//----------- Kommunikation über Sex -----------
egen sexcomm = rowmean (sexcomm01 sexcomm02)
replace sexcomm = .m if sexcomm01 == .m & sexcomm02 == .m
replace sexcomm = .n if sexcomm == . 
tab sexcomm, missing


//----------- Big Five -----------
egen bigfiveE = rowmean (bigfiveE01 bigfiveE02)	
replace	bigfiveE = .m if bigfiveE01 == .m & bigfiveE02 == .m
replace bigfiveE = .n if bigfiveE == .
tab bigfiveE, missing

egen bigfiveA = rowmean (bigfiveA01 bigfiveA02 bigfiveA03)	
replace	bigfiveA = .m if bigfiveA01 == .m & bigfiveA02 == .m & bigfiveA03 == .m
replace bigfiveA = .n if bigfiveA == .
tab bigfiveA, missing

egen bigfiveC = rowmean (bigfiveC01 bigfiveC02)				
replace	bigfiveC = .m if bigfiveC01 == .m & bigfiveC02 == .m
replace bigfiveC = .n if bigfiveC == .
tab bigfiveC, missing

egen bigfiveN = rowmean (bigfiveN01 bigfiveN02)				
replace	bigfiveN = .m if bigfiveN01 == .m & bigfiveN02 == .m
replace bigfiveN = .n if bigfiveN == .
tab bigfiveN, missing


//----------- Selbstsicherheit -----------
egen sexselfconfA = rowmean (sexselfconf01 sexselfconf02)
replace	sexselfconfA = .m if sexselfconf01 == .m & sexselfconf02 == .m
replace sexselfconfA = .n if sexselfconfA == .
tab sexselfconfA, missing
	
egen sexselfconfB = rowmean (sexselfconf03 sexselfconf04)
replace	sexselfconfB = .m if sexselfconf03 == .m & sexselfconf04 == .m
replace sexselfconfB = .n if sexselfconfB == .	
tab sexselfconfB, missing


//----------- Perfektionismus - selbst orientiert -----------
egen perfself = rowmean (perfself01 perfself02)	
replace	perfself = .m if perfself01 == .m & perfself02 == .m
replace perfself = .n if perfself == .	
tab perfself, missing


//----------- Perfektionismus - Partner orientiert -----------
egen perfpartner = rowmean (perfpartner01 perfpartner02)
replace	perfpartner = .m if perfpartner01 == .m & perfpartner02 == .m
replace perfpartner = .n if perfpartner == .	
tab perfpartner, missing


//----------- Gesundheit psychisch -----------
egen healthment = rowmean (healthment01 healthment02)
replace	healthment = .m if healthment01 == .m & healthment02 == .m
replace healthment = .n if healthment == .
tab healthment, missing


//----------- Verhütung -----------							
gen contracept_no = 0
replace contracept_no = 1 if contracept01 == 1

gen contracept_horm = 0
replace contracept_horm = 1 if contracept03 == 1 | contracept04 == 1 | contracept05 == 1 | contracept06 == 1
tab contracept_horm, missing

gen contracept_other = 0																						//<------- vielleicht müssen wir hier auch noch "Kondom" rausnehmen, da die meisten das nur zur Übergangsverhütung einsetzen?
replace contracept_other = 1 if contracept02 == 1 | contracept07 == 1 | contracept08 == 1 | contracept09 == 1
replace contracept_other = 0 if contracept03 == 1 | contracept04 == 1 | contracept05 == 1 | contracept06 == 1	//entfernt "hormonell verhütende Menschen" aus other, die nur zusätzlich ander als hormonell verhüten
tab contracept_other, missing

replace contracept_no = 0 if contracept_horm == 1 | contracept_other == 1										//entfernt die Fälle aus "keine Verhütung", die auch eine Verhütung angegeben haben
tab contracept_no, missing


//----------- Körperbild -----------
egen bodyimage = rowmean (bodyimage01 bodyimage02)
replace	bodyimage = .m if bodyimage01 == .m & bodyimage02 == .m
replace bodyimage = .n if bodyimage == .
tab bodyimage, missing


//----------- Partner Attraktivität -----------
egen partnerattr = rowmean (partnerattr01 partnerattr02)
replace	partnerattr = .m if partnerattr01 == .m & partnerattr02 == .m
replace partnerattr = .n if partnerattr == .
tab partnerattr, missing


//----------- Qualität Sex -----------					
egen sexqual = rowmean (sexqual01 sexqual02)
replace	sexqual = .m if sexqual01 == .m & sexqual02 == .m
replace sexqual = .n if sexqual == .
tab sexqual, missing


//----------- sexuelle Zufriedenheit -----------
egen sexsat = rowmean(sexsat01 sexsat02 sexsat04 sexsat03)
replace	sexsat = .m if sexsat01 - sexsat03 == .m
replace sexsat = .n if sexsat == .
tab sexsat, missing

log close
