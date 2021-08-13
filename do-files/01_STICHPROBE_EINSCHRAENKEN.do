log using "${logDirectory}01_Stichprobe_Einschränken.log", replace

/********** STICHPROBE EINSCHRAENKEN ************
Eingrenzen des Datensatzes auf relevante Stichprobe
*/


drop if dispcode ==22 										//entfernt Befragte, die nicht vollständig ausgefüllt haben

drop if gender == 2											//entfernt Männer
drop if gender == 3											//entfernt "andere"

drop if coupletype == 1										//entfernt "ohne Beziehung"

drop if sexorient > 3										//entfernt alle homosexuellen und "lehne ab" (Was passiert mit .n?, das ist danach nicht mehr da - auch entfernt?)

drop if sexact_time == .m									//entfernt alle, die keine sexuellen Erfahrungen angegeben haben

log close
