log using "${logDirectory}11_Variablen_Verteilung.log", replace

//###############################################################

//************ Histogramme + Boxplots für benutzte Variablen ************

label variable sexsat01 "Zuf. allgemein"
label variable sexsat02 "Zuf. Befriedigung"
label variable sexsat03 "Zuf. Gestaltung"
label variable sexquan "Häufigkeit"
label variable sexactBalance "Praktiken"
label variable sexorgasm01 "Orgasmus"
label variable sexfan02 "Fantasien"
label variable sexmastB01 "Masturbation"
label variable sexpornB01 "Pornografie"
label variable sexcomm01 "Kommunikation"
label variable sexnet01 "Abl. Körperbild"
label variable sexnet02 "Abl. Performanz"
label variable couplebond01 "Part. Intensität"
label variable couplebond02 "Part. Verbindlichkeit"
label variable coupleint01 "Part. Intimität"
label variable age "Alter"
label variable education "Bildung"
label variable stress01 "Stress"
label variable healthphys01 "Gesundheit phys."
label variable bigfiveO "Offenheit"
label variable coupleduration "Beziehungsdauer"


graph set window fontface "Calibri Light"

foreach var of varlist sexsat01 sexsat02 sexsat03 sexorgasm01 sexcomm01 sexnet01 sexnet02 couplebond01 couplebond02 coupleint01 sexpornB01 sexmastB01 sexfan02 education stress01 healthphys01 bigfiveO {												//schaut sich alle Variablen des Datensatzes an
   
	#delimit ;
	
	graph drop _all;
   
	local varlabel : var label `var';

	graph box `var',
		box(1, lcolor(black) color(gs12))
		marker(1, mcolor(black) msize(small))
		medtype(cline)
		medline(lcolor(black) lwidth(thick))
		intensity(70)
		ylabel(1(1)7) 
		horizontal 
		ytitle("") 
		fysize(20)
		graphregion(color(white))
		plotregion(color(white) margin(19 9.5 0 0)) 
		bgcolor(white)
		name(`var'BOX);

	histogram `var',
		frequency
		yaxis(2)
		normal
		normopts(lpattern(solid) lwidth(medium) lcolor(black))
		discrete
		xlabel(1(1)7)
		barwidth(0.5)
		color(gs12)
		lcolor(black)
		fintensity(70)
		xtitle("")
		ytitle("", axis(2))
		ylabel(0, axis(1) nogrid)
		yscale(axis(1) range(0[200]800) off)
		yscale(axis(2) range(0[200]800))
		ylabel(0 200 400 600 800, axis(2))
		ytick(100[200]700, axis(2))
		ymtick(0[200]800, axis(2))
		graphregion(color(white))
		plotregion(color(white)) 
		bgcolor(white)
		legend(off)
		name(`var'HIST);	
	
	graph combine `var'HIST `var'BOX, 
		cols(1) 
		rows(2) 
		xsize(3) 
		ysize(3)
		graphregion(color(white))
		plotregion(color(white))
		title("`varlabel'", color(black));
	
	graph export "${graphDirectory}graph-`var'DIST.eps", replace;
	
	graph drop _all;

	#delimit cr
   
}


#delimit ;
	
	graph drop _all;
   
	local varlabel : var label bigfiveO;

	graph box bigfiveO,
		box(1, lcolor(black) color(gs12))
		marker(1, mcolor(black) msize(small))
		medtype(cline)
		medline(lcolor(black) lwidth(thick))
		intensity(70)
		ylabel(1(1)7) 
		horizontal 
		ytitle("") 
		fysize(20)
		graphregion(color(white))
		plotregion(color(white) margin(23 9.5 0 0)) 
		bgcolor(white)
		name(bigfiveOBOX);

	histogram bigfiveO,
		frequency
		yaxis(2)
		normal
		normopts(lpattern(solid) lwidth(medium) lcolor(black))
		discrete
		xlabel(1(1)7)
		barwidth(0.3)
		color(gs12)
		lcolor(black)
		fintensity(70)
		xtitle("")
		ytitle("", axis(2))
		ylabel(0, axis(1) nogrid)
		yscale(axis(1) range(0[200]800) off)
		yscale(axis(2) range(0[200]800))
		ylabel(0 200 400 600 800, axis(2))
		ytick(100[200]700, axis(2))
		ymtick(0[200]800, axis(2))
		graphregion(color(white))
		plotregion(color(white) margin(12 6 0 0)) 
		bgcolor(white)
		legend(off)
		name(bigfiveOHIST);	
	

	graph combine bigfiveOHIST bigfiveOBOX, 
		cols(1) 
		rows(2) 
		xsize(3) 
		ysize(3)
		graphregion(color(white))
		plotregion(color(white))
		title("`varlabel'", color(black));
	
	graph export "${graphDirectory}graph-bigfiveODIST.eps", replace;
	
	graph drop _all;

#delimit cr

#delimit ;
	
	graph drop _all;
   
	local varlabel : var label sexactBalance;

	graph box sexactBalance,
		box(1, lcolor(black) color(gs12))
		marker(1, mcolor(black) msize(small))
		medtype(cline)
		medline(lcolor(black) lwidth(thick))
		intensity(70)
		ylabel(-7(1)7) 
		horizontal 
		ytitle("") 
		fysize(20)
		graphregion(color(white))
		plotregion(color(white) margin(18 9 0 0)) 
		bgcolor(white)
		name(sexactBalanceBOX);

	histogram sexactBalance,
		frequency
		yaxis(2)
		normal
		normopts(lpattern(solid) lwidth(medium) lcolor(black))
		discrete
		xlabel(-7(1)7)
		barwidth(0.5)
		color(gs12)
		lcolor(black)
		fintensity(70)
		xtitle("")
		ytitle("", axis(2))
		ylabel(0, axis(1) nogrid)
		yscale(axis(1) range(0[200]800) off)
		yscale(axis(2) range(0[200]800))
		ylabel(0 200 400 600 800, axis(2))
		ytick(100[200]700, axis(2))
		ymtick(0[200]800, axis(2))
		graphregion(color(white))
		plotregion(color(white) margin(12 6 0 0)) 
		bgcolor(white)
		legend(off)
		name(sexactBalanceHIST);	
	

	graph combine sexactBalanceHIST sexactBalanceBOX, 
		cols(1) 
		rows(2) 
		xsize(3) 
		ysize(3)
		graphregion(color(white))
		plotregion(color(white))
		title("`varlabel'", color(black));
	
	graph export "${graphDirectory}graph-sexactBalanceDIST.eps", replace;
	
	graph drop _all;

#delimit cr

#delimit ;
	
	graph drop _all;
   
	local varlabel : var label sexquan;

	graph box sexquan,
		box(1, lcolor(black) color(gs12))
		marker(1, mcolor(black) msize(small))
		medtype(cline)
		medline(lcolor(black) lwidth(thick))
		intensity(70)
		ylabel(1(1)5) 
		horizontal 
		ytitle("") 
		fysize(20)
		graphregion(color(white))
		plotregion(color(white) margin(22.5 19.5 0 0))
		bgcolor(white)
		name(sexquanBOX);

	histogram sexquan,
		frequency
		yaxis(2)
		normal
		normopts(lpattern(solid) lwidth(medium) lcolor(black))
		discrete
		xlabel(1(1)5)
		barwidth(0.5)
		color(gs12)
		lcolor(black)
		fintensity(70)
		xtitle("")
		ytitle("", axis(2))
		ylabel(0, axis(1) nogrid)
		yscale(axis(1) range(0[200]800) off)
		yscale(axis(2) range(0[200]800))
		ylabel(0 200 400 600 800, axis(2))
		ytick(100[200]700, axis(2))
		ymtick(0[200]800, axis(2))
		graphregion(color(white))
		plotregion(color(white) margin(2 10 0 0)) 
		bgcolor(white)
		legend(off)
		name(sexquanHIST);	
	

	graph combine sexquanHIST sexquanBOX, 
		cols(1) 
		rows(2) 
		xsize(3) 
		ysize(3)
		graphregion(color(white))
		plotregion(color(white))
		title("`varlabel'", color(black));
	
	graph export "${graphDirectory}graph-sexquanDIST.eps", replace;
	
	graph drop _all;

#delimit cr

#delimit ;
	
	graph drop _all;
   
	local varlabel : var label age;

	graph box age,
		box(1, lcolor(black) color(gs12))
		marker(1, mcolor(black) msize(small))
		medtype(cline)
		medline(lcolor(black) lwidth(thick))
		intensity(70)
		ylabel(0(5)70) 
		horizontal 
		ytitle("") 
		fysize(20)
		graphregion(color(white))
		plotregion(color(white) margin(18 10 0 0))
		bgcolor(white)
		name(ageBOX);

	histogram age,
		frequency
		yaxis(2)
		normal
		normopts(lpattern(solid) lwidth(medium) lcolor(black))
		discrete
		xlabel(0(5)70)
		barwidth(0.5)
		color(gs12)
		lcolor(black)
		fintensity(70)
		xtitle("")
		ytitle("", axis(2))
		ylabel(0, axis(1) nogrid)
		yscale(axis(1) range(0[50]200) off)
		yscale(axis(2) range(0[50]200))
		ylabel(0 50 100 150 200, axis(2))
		ytick(50[50]200, axis(2))
		ymtick(0[50]200, axis(2))
		graphregion(color(white))
		plotregion(color(white) margin(12 10 0 0)) 
		bgcolor(white)
		legend(off)
		name(ageHIST);	
	

	graph combine ageHIST ageBOX, 
		cols(1) 
		rows(2) 
		xsize(3) 
		ysize(3)
		graphregion(color(white))
		plotregion(color(white))
		title("`varlabel'", color(black));
	
	graph export "${graphDirectory}graph-ageDIST.eps", replace;
	
	graph drop _all;

#delimit cr

#delimit ;
	
	graph drop _all;
   
	local varlabel : var label coupleduration;

	graph box coupleduration,
		box(1, lcolor(black) color(gs12))
		marker(1, mcolor(black) msize(small))
		medtype(cline)
		medline(lcolor(black) lwidth(thick))
		intensity(80)
		ylabel(0(5)45) 
		horizontal 
		ytitle("") 
		fysize(20)
		graphregion(color(white))
		plotregion(color(white) margin(18 10 0 0))
		bgcolor(white)
		name(coupledurationBOX);

	histogram coupleduration,
		bin(90)
		frequency
		yaxis(2)
		normal
		normopts(lpattern(solid) lwidth(medium) lcolor(black))
		xlabel(0(5)45)
		barwidth(0.5)
		color(gs12)
		lcolor(black)
		fintensity(70)
		xtitle("")
		ytitle("", axis(2))
		ylabel(0, axis(1) nogrid)
		yscale(axis(1) range(0[50]200) off)
		yscale(axis(2) range(0[50]200))
		ylabel(0 50 100 150 200, axis(2))
		ytick(50[50]200, axis(2))
		ymtick(0[50]200, axis(2))
		graphregion(color(white))
		plotregion(color(white) margin(12 10 0 0)) 
		bgcolor(white)
		legend(off)
		name(coupledurationHIST);	
	

	graph combine coupledurationHIST coupledurationBOX, 
		cols(1) 
		rows(2) 
		xsize(3) 
		ysize(3)
		graphregion(color(white))
		plotregion(color(white))
		title("`varlabel'", color(black));
	
	graph export "${graphDirectory}graph-coupledurationDIST.eps", replace;
	
	graph drop _all;

#delimit cr

//

log close
