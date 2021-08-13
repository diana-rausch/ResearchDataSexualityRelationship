log using "${logDirectory}08_Multikolliniarität.log", replace

//###############################################################

//************ Multikolliniarität Check ************
// Test auf Multikollinearität der Variablen im Modell durch Betrachtung des Variance Inflation Factors (VIF)

gen randomVar = runiform()


regress sexsatlatMeasurementPred sexactBalance sexorgasm01 sexquan sexcomm01 distractMeasurementPred coupleMeasurementPred
estat vif

regress sexquan sexactBalance sexfan02 coupleMeasurementPred
estat vif

regress sexactBalance sexpornB01 sexfan02 sexcomm01 distractMeasurementPred
estat vif

regress sexorgasm01 sexactBalance distractMeasurementPred
estat vif

regress sexfan02 sexpornB01 sexmastB01
estat vif

regress distractMeasurementPred sexpornB01 sexcomm01 coupleMeasurementPred
estat vif


//lateral

regress randomVar sexsatlatMeasurementPred sexquan sexactBalance sexorgasm01 sexpornB01 sexmastB01 sexfan02 sexcomm01 distractMeasurementPred coupleMeasurementPred 
estat vif

drop randomVar


log close
